import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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
  final bool isPrivacyPolicyAccepted;
  const VerifyIdcardScreen({
    required this.name,
    required this.email,
    required this.gender,
    required this.country,
    required this.countryFlag,
    required this.password,
    required this.confirmPassword,
    required this.isPrivacyPolicyAccepted,
    super.key,
  });

  @override
  State<VerifyIdcardScreen> createState() => _VerifyIdcardScreenState();
}

class _VerifyIdcardScreenState extends State<VerifyIdcardScreen> {
  CameraController? _cameraController;
  bool _isProcessing = false;
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final TextEditingController _ageController = TextEditingController();
  String status = 'Approved';
  String? idCardPhoto;
  String dateOfBirth = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await _cameraController!.initialize();

      // Check the camera orientation and adjust accordingly
      if (mounted) {
        if (_cameraController!.description.lensDirection == CameraLensDirection.front) {
          // For front camera, flip preview horizontally
          setState(() {
            _cameraController = CameraController(
              cameras[0],
              ResolutionPreset.high,
              enableAudio: false,
              imageFormatGroup: ImageFormatGroup.yuv420,
            );
          });
        }
        setState(() {});
        _startTextScanning();
      }
    }
  }

  /// Start scanning the ID text in real-time
  void _startTextScanning() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    try {
      _cameraController!.startImageStream((CameraImage image) async {
        if (_isProcessing) return;

        _isProcessing = true;

        try {
          final RecognizedText recognizedText = await _processImage(image);
          final String? extractedDOB = extractDOBFromText(recognizedText.text);

          if (extractedDOB != null) {
            int age = calculateAge(extractedDOB);
            setState(() {
              dateOfBirth = extractedDOB;
              _ageController.text = age.toString();
            });
          }
        } catch (e) {
          debugPrint("Error processing image: $e");
        }

        _isProcessing = false;
      });
    } on PlatformException catch (e) {
      debugPrint("Error processing image: $e");
    } catch (e) {
      debugPrint("Error processing image: $e");
    }
  }

  /// Converts CameraImage to ML Kit InputImage
  Future<RecognizedText> _processImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: Platform.isAndroid ? InputImageFormat.nv21 : InputImageFormat.yuv420,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );

    return await _textRecognizer.processImage(inputImage);
  }

  /// Extracts Date of Birth from text
  String? extractDOBFromText(String text) {
    List<String> dobIndicators = ['Date of Birth', 'DOB', 'Born on', 'Birthdate', 'DATE OF BIRTH'];

    for (String indicator in dobIndicators) {
      final int index = text.indexOf(indicator);
      if (index != -1) {
        // Regex for MM.dd.yyyy (e.g., 10.17.2009) and MMM dd yyyy (e.g., Oct 17 2009)
        final RegExp dateRegex = RegExp(
          r'\b(\d{2}\.\d{2}\.\d{4})\b|\b([A-Za-z]{3} \d{1,2} \d{4})\b',
        );
        final match = dateRegex.firstMatch(text.substring(index));
        if (match != null) {
          return match.group(0);
        }
      }
    }
    return null;
  }

  /// Calculates age from Date of Birth
  int calculateAge(String dobString) {
    List<String> formats = [
      "MM.dd.yyyy", // 10.17.2009
      "MMM dd yyyy", // Oct 17 2009
    ];
    DateTime? dob;

    for (var format in formats) {
      try {
        dob = DateFormat(format).parse(dobString);
        break;
      } catch (e) {
        continue;
      }
    }

    if (dob == null) return 0;

    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
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
                          _initializeCamera();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: Colors.black.withOpacity(
                              0.7,
                            ),
                          ),
                          child: _cameraController != null && _cameraController!.value.isInitialized
                              ? SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                      aspectRatio: _cameraController!.value.aspectRatio,
                                      child: Transform.rotate(
                                        angle: Platform.isIOS ? 0 : -270 * 3.1415927 / 180, // Rotate 90 degrees counterclockwise
                                        child: CameraPreview(_cameraController!),
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Gaps.hGap20,
                      AppTextField(
                        isReadOnly: true,
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
                              /// Formats DOB into "dd/MM/yyyy"
                              String formatDOB(String dateOfBirth) {
                                List<String> formats = [
                                  "MM.dd.yyyy", // 10.17.2009
                                  "MMM dd yyyy", // Oct 17 2009
                                ];

                                DateTime? parsedDate;

                                for (var format in formats) {
                                  try {
                                    parsedDate = DateFormat(format).parse(dateOfBirth);
                                    break;
                                  } catch (e) {
                                    continue;
                                  }
                                }

                                if (parsedDate == null) {
                                  throw const FormatException("Invalid Date of Birth format");
                                }

                                return DateFormat("dd/MM/yyyy").format(parsedDate);
                              }

                              final ageText = _ageController.text;
                              final age = int.tryParse(ageText);

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
                                  // idCardPhoto: '',
                                  // image: XFile(''),
                                  age: _ageController.text,
                                  dateOfBirth: formattedDOB,
                                  isPrivacyPolicyAccepted: widget.isPrivacyPolicyAccepted,
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
