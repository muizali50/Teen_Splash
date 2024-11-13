import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/sub_features/dashborad/views/admin_dashboard.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/authentication/views/onboarding_screen.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/bottom_nav_bar.dart';
import 'package:teen_splash/features/users/views/hydrated_popup.dart';
import 'package:teen_splash/firebase_options.dart';
import 'package:teen_splash/user_provider.dart';

late final SharedPreferences prefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<TimeOfDay> hydrationTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 14, minute: 0),
    const TimeOfDay(hour: 19, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scheduleHydrationReminders();
      },
    );
  }

  // Function to show the hydration popup
  void showHydrationPopup() {
    if (navigatorKey.currentContext != null) {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: HydratedPopup(),
        ),
      );
    }
  }

  // Schedule the hydration reminders
  void scheduleHydrationReminders() {
    Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        final now = TimeOfDay.now();
        for (TimeOfDay time in hydrationTimes) {
          if (now.hour == time.hour && now.minute == time.minute) {
            showHydrationPopup();
            break;
          }
        }
      },
    );
  }

  // This widget is the root of your application.
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
            create: (context) => UserProvider(),
          ),
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
          home: FirebaseAuth.instance.currentUser == null
              ? kIsWeb
                  ? const LoginScreen()
                  : const OnboardingScreen()
              : kIsWeb
                  ? const AdminDashboard()
                  : const BottomNavBar(),
        ),
      ),
    );
  }
}
