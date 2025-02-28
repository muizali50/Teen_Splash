import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/firebase_options.dart';
import 'package:teen_splash/services/notification_services.dart';
import 'package:teen_splash/services/splash_screen.dart';
import 'package:teen_splash/user_provider.dart';

late final SharedPreferences prefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final notificationsService = NotificationsService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await notificationsService.init(navigatorKey);
  notificationsService.scheduleDailyNotifications();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          // ChangeNotifierProvider<UserProvider>(
          //   create: (context) => UserProvider(),
          // ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()..getUser(),
          ),
        ],
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
          home: const SplashScreen(),
          // Consumer<UserProvider>(
          //   builder: (context, userProvider, child) {
          //     final firebaseUser = userProvider.firebaseUser;
          //     if (FirebaseAuth.instance.currentUser == null) {
          //       return kIsWeb ? const LoginScreen() : const OnboardingScreen();
          //     } else if (kIsWeb) {
          //       return const AdminDashboard();
          //     }
          // else if (firebaseUser == null) {
          //   // If the firebaseUser hasn't been fetched yet, show a loading screen
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          //     else if (firebaseUser != null &&
          //         firebaseUser.status == 'Pending') {
          //       return const LoginScreen();
          //     } else {
          //       return const BottomNavBar();
          //     }
          //   },
          // ),
          // home: FirebaseAuth.instance.currentUser == null
          //     ? kIsWeb
          //         ? const LoginScreen()
          //         : const OnboardingScreen()
          //     : kIsWeb
          //         ? const AdminDashboard()
          //         : UserProvider().firebaseUser?.status == 'Pending'
          //             ? const LoginScreen()
          //             : const BottomNavBar(),
        ),
      ),
    );
  }
}
