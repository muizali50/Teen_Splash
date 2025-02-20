import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/features/admin/views/sub_features/dashborad/views/admin_dashboard.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/authentication/views/onboarding_screen.dart';
import 'package:teen_splash/features/users/views/bottom_nav_bar.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AuthenticationBloc authenticationBloc;
  late final UserProvider userProvider;
  late VideoPlayerController _controller;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();

    if (FirebaseAuth.instance.currentUser != null &&
        userProvider.firebaseUser == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }

    _controller = VideoPlayerController.asset("assets/splash.mp4")
      ..initialize().then(
        (_) {
          setState(() {});
          _controller.play();
        },
      );

    _controller.addListener(
      () {
        if (_controller.value.position == _controller.value.duration) {
          _navigationTimer =
              Timer(const Duration(seconds: 1), checkLoginStatus);
        }
      },
    );
  }

  void checkLoginStatus() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final firebaseUser = userProvider.firebaseUser;

    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              kIsWeb ? const LoginScreen() : const OnboardingScreen(),
        ),
      );
    } else if (kIsWeb) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboard(),
        ),
      );
    } else if (firebaseUser != null && firebaseUser.status == 'Pending' ||
        int.tryParse(firebaseUser!.age!)! > 19) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC45856),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: Container(
                    color: const Color(0xFFC45856),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
