import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                scale: 5,
                'assets/images/logo.png',
              ),
            ),
            Gaps.hGap40,
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // 25% opacity
                      offset: const Offset(-4, 4), // x = -4, y = 4
                      blurRadius: 4, // blur = 4
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          scale: 3,
                          'assets/images/amico.png',
                        ),
                      ),
                      Gaps.hGap50,
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap20,
                      Text(
                        'Don’t worry! It happens. Please enter the email address associated with your account.',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Gaps.hGap30,
                      AppTextField(
                        controller: _emailController,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/email.png',
                        hintText: 'Email',
                      ),
                      Gaps.hGap50,
                      AppPrimaryButton(
                        text: 'Reset Password',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
