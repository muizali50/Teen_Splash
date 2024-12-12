import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class VerifyIdcardScreen extends StatefulWidget {
  final String name;
  final String email;
  final String gender;
  final String country;
  final String countryFlag;
  final String password;
  final String confirmPassword;
  const VerifyIdcardScreen({
    required this.name,
    required this.email,
    required this.gender,
    required this.country,
    required this.countryFlag,
    required this.password,
    required this.confirmPassword,
    super.key,
  });

  @override
  State<VerifyIdcardScreen> createState() => _VerifyIdcardScreenState();
}

class _VerifyIdcardScreenState extends State<VerifyIdcardScreen> {
  final TextEditingController _ageController = TextEditingController();
  String status = 'Pending';
  String? idCardPhoto;
  @override
  Widget build(BuildContext context) {
    final authenticationBloc = context.watch<AuthenticationBloc>();
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
                      GestureDetector(
                        onTap: () async {
                          final pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (pickedFile != null) {
                            final coverPhotoUrl = pickedFile.path;
                            setState(
                              () {
                                idCardPhoto = coverPhotoUrl;
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 162,
                          width: 335,
                          decoration: BoxDecoration(
                            image: idCardPhoto != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(idCardPhoto!),
                                    ),
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: idCardPhoto != null
                                ? null
                                : Colors.black.withOpacity(
                                    0.7,
                                  ),
                          ),
                        ),
                      ),
                      Gaps.hGap20,
                      AppTextField(
                        isInputTypeNumber: true,
                        isInputFormattersDigits: true,
                        controller: _ageController,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/person.png',
                        hintText: 'Age',
                      ),
                      Gaps.hGap40,
                      BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is Registered) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Request is sent to admin for verification',
                                ),
                              ),
                            );
                            // Navigator.of(context).pushAndRemoveUntil(
                            //   MaterialPageRoute(
                            //     builder: (
                            //       context,
                            //     ) =>
                            //         const BottomNavBar(),
                            //   ),
                            //   (route) => false,
                            // );
                          }
                        },
                        builder: (context, state) {
                          if (state is Registering) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is RegisteredFailure) {
                            SchedulerBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.message,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return AppPrimaryButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (idCardPhoto!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please select the id card photo',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (_ageController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please enter your age',
                                    ),
                                  ),
                                );
                                return;
                              }
                              authenticationBloc.add(
                                RegisterEvent(
                                  name: widget.name,
                                  email: widget.email,
                                  gender: widget.gender.toString(),
                                  country: widget.country.toString(),
                                  countryFlag: widget.countryFlag.toString(),
                                  password: widget.password,
                                  confirmPassword: widget.confirmPassword,
                                  status: status,
                                  idCardPhoto: idCardPhoto.toString(),
                                  image: XFile(idCardPhoto!),
                                  age: _ageController.text,
                                ),
                              );
                            },
                          );
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
