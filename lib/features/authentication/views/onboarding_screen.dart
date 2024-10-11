import 'package:flutter/material.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/authentication/views/sub_features/views/signup_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Vendor Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Lexend',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/onboarding.png',
                ),
                Center(
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                Gaps.hGap10,
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Your gateway to exclusive discounts and the hottest teen events! Get ready to save big and enjoy unforgettable experiences!',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                Gaps.hGap40,
                AppPrimaryButton(
                  text: 'Login',
                  onTap: () {
                     Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const LoginScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap20,
                AppPrimaryButton(
                  isBorder: true,
                  text: 'Sign Up',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const SignupScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap25,
                Center(
                  child: Text(
                    'Continue as a Guest',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Lexend',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
