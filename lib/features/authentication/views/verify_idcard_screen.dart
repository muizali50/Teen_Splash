import 'package:flutter/material.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class VerifyIdcardScreen extends StatefulWidget {
  const VerifyIdcardScreen({super.key});

  @override
  State<VerifyIdcardScreen> createState() => _VerifyIdcardScreenState();
}

class _VerifyIdcardScreenState extends State<VerifyIdcardScreen> {
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
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap10,
                      const Text(
                        'Verify your ID card',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Gaps.hGap40,
                      Container(
                        height: 162,
                        width: 335,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: Colors.black.withOpacity(
                            0.7,
                          ),
                        ),
                      ),
                      Gaps.hGap20,
                      Container(
                        padding: const EdgeInsets.all(
                          5.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: const Color(
                            0xFFF4F4F4,
                          ),
                        ),
                        child: Row(
                          children: [
                            ImageIcon(
                              color: Theme.of(context).colorScheme.primary,
                              const AssetImage(
                                'assets/icons/person.png',
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              '18 years old',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                size: 22,
                                color: Color(0xFF1FAF08),
                                Icons.check_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.hGap40,
                      AppPrimaryButton(
                        text: 'Sign Up',
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (
                          //       context,
                          //     ) =>
                          //         const VerifyIdcardScreen(),
                          //   ),
                          // );
                        },
                      ),
                      Gaps.hGap50,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (
                                    context,
                                  ) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
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
