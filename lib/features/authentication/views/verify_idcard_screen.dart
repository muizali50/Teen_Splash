import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/users/views/bottom_nav_bar.dart';
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
  String status = 'Approved';
  String? idCardPhoto;
  String dateOfBirth = '';

  Future<void> pickImageAndExtractDOB() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      setState(
        () {
          idCardPhoto = imagePath;
        },
      );

      // Extract text from the image
      final recognizedText = await extractTextFromImage(imagePath);

      // Extract DOB from the recognized text
      final dob = extractDOBFromText(recognizedText);

      if (dob != null) {
        setState(
          () {
            dateOfBirth = dob; // Update the UI with extracted DOB
            _ageController.text = calculateAge(dob).toString(); // Auto-fill age
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not detect Date of Birth'),
          ),
        );
      }
    }
  }

  Future<String> extractTextFromImage(String imagePath) async {
    final InputImage inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    return recognizedText.text;
  }

  String? extractDOBFromText(String text) {
    // Possible terms around DOB
    List<String> dobIndicators = [
      'Date of Birth',
      'Date of birth',
      'DOB',
      'Born on',
      'Birthdate',
      'Date of Birth:',
      'DATE OF BIRTH',
    ];

    // Look for these terms in the text
    for (String indicator in dobIndicators) {
      final indicatorIndex = text.indexOf(indicator);
      if (indicatorIndex != -1) {
        // Found DOB indicator, now look for date format nearby
        final dateRegex =
            RegExp(r'\b\d{2}[-\s./]?\d{2}[-\s./]?\d{4}\b'); // Date formats
        final match = dateRegex.firstMatch(text.substring(indicatorIndex));
        if (match != null) {
          final dobString = match.group(0);
          if (dobString != null) {
            return dobString;
          }
        }
      }
    }
    return null;
  }

  int calculateAge(String dobString) {
    // Parse the dobString to a DateTime object
    List<String> formats = [
      "dd.MM.yyyy", // 12.09.2001
      "dd MM yyyy", // 12 09 2002
      "dd/MM/yyyy", // 12/09/2002
      "dd MMMM yyyy", // 12 September 2001
      "dd-MM-yyyy", // 12-09-2001
    ];

    DateTime? dob;
    for (var format in formats) {
      try {
        dob = DateFormat(format).parse(dobString);
        break; // Exit loop once valid date is found
      } catch (e) {
        continue;
      }
    }

    if (dob == null) {
      throw FormatException("Invalid Date of Birth format.");
    }

    // Calculate age
    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    // Adjust age if birthday has not occurred yet this year
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

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
                          pickImageAndExtractDOB();
                          // final pickedFile = await ImagePicker().pickImage(
                          //   source: ImageSource.gallery,
                          // );

                          // if (pickedFile != null) {
                          //   final coverPhotoUrl = pickedFile.path;
                          //   setState(
                          //     () {
                          //       idCardPhoto = coverPhotoUrl;
                          //     },
                          //   );
                          // }
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
                            // ScaffoldMessenger.of(
                            //   context,
                            // ).showSnackBar(
                            //   const SnackBar(
                            //     content: Text(
                            //       'Request is sent to admin for verification',
                            //     ),
                            //   ),
                            // );
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    const BottomNavBar(),
                              ),
                              (route) => false,
                            );
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
                              String formatDOB(String dateOfBirth) {
                                // List of possible formats the DOB can be in
                                List<String> formats = [
                                  "dd.MM.yyyy", // 12.09.2001
                                  "dd/MM/yyyy", // 12/09/2002
                                  "dd-MM-yyyy", // 12-09-2002
                                  "dd MMMM yyyy", // 12 September 2001
                                ];

                                DateTime? parsedDate;

                                // Try each format to parse the date
                                for (var format in formats) {
                                  try {
                                    parsedDate =
                                        DateFormat(format).parse(dateOfBirth);
                                    break; // If we succeed in parsing, exit the loop
                                  } catch (e) {
                                    continue; // Continue to try other formats if parsing fails
                                  }
                                }

                                // If no valid date found, return an empty string or throw an error
                                if (parsedDate == null) {
                                  throw const FormatException(
                                      "Invalid Date of Birth format");
                                }

                                // Return the date in "dd/MM/yyyy" format
                                return DateFormat("dd/MM/yyyy")
                                    .format(parsedDate);
                              }

                              final ageText = _ageController.text;
                              final age = int.tryParse(ageText);

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
                              if (age == null || age < 13 || age > 19) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Teens Only',
                                    ),
                                  ),
                                );
                                return;
                              }
                              String formattedDOB = formatDOB(dateOfBirth);
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
                                  dateOfBirth: formattedDOB,
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
