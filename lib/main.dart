import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/sub_features/dashborad/views/admin_dashboard.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/firebase_options.dart';
import 'package:teen_splash/services/notification_services.dart';
import 'package:teen_splash/services/push_notification_service.dart';
import 'package:teen_splash/services/splash_screen.dart';
import 'package:teen_splash/user_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background Notification: ${message.notification?.title}");
}

late final SharedPreferences prefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final notificationsService = NotificationsService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await notificationsService.init(navigatorKey);
    notificationsService.scheduleDailyNotifications();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Get the initial notification when the app is terminated
  RemoteMessage? initialMessage = await messaging.getInitialMessage();

  // Initialize push notification service
  final pushNotificationService = PushNotificationService(navigatorKey);
  await pushNotificationService.init();

  final NotificationAppLaunchDetails? launchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String? payload;
  if (launchDetails?.didNotificationLaunchApp ?? false) {
    payload = launchDetails!.notificationResponse?.payload;
  }

  runApp(MyApp(
    payload: payload,
    initialMessage: initialMessage,
  ));
}

class MyApp extends StatefulWidget {
  final RemoteMessage? initialMessage;
  final String? payload;
  const MyApp({
    super.key,
    this.payload,
    this.initialMessage,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()..getUser(),
          ),
        ],
        child: InAppNotification(
          child: MaterialApp(
            title: 'Teen Splash',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                surface: Color(0xFFFFFFFF),
                onSurface: Color(0xFF999999),
                primary: Color(0xFF272575),
                secondary: Color(0xFF00BFFF),
                tertiary: Color(0xFFFF69B4),
              ),
            ),
            home: kIsWeb
                ? FirebaseAuth.instance.currentUser == null
                    ? LoginScreen()
                    : AdminDashboard()
                : SplashScreen(
                    payload: widget.payload,
                    initialMessage: widget.initialMessage,
                  ),
          ),
        ),
      ),
    );
  }
}
