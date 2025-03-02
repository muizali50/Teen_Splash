import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/authentication/views/sub_features/widgets/select_gender_popup.dart';
import 'package:teen_splash/features/authentication/views/verify_idcard_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? selectedCountry;
  String? selectedCountryFlag;
  String selectedGender = '';
  bool agreeToTerms = false;
  void updateGender(
    String gender,
  ) {
    setState(
      () {
        selectedGender = gender;
      },
    );
  }

  Future<void> _launchWebsite(String? url, BuildContext context) async {
    if (url != null && await launchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch the link.',
          ),
        ),
      );
    }
  }

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
                      Gaps.hGap40,
                      AppTextField(
                        controller: _nameController,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/person.png',
                        hintText: 'Full Name',
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _emailController,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/email.png',
                        hintText: 'Email',
                      ),
                      Gaps.hGap15,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 13,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/gender.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              selectedGender == 'male'
                                  ? 'Male'
                                  : selectedGender == 'female'
                                      ? 'Female'
                                      : 'Select Gender',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: selectedGender == 'male'
                                    ? Theme.of(context).colorScheme.primary
                                    : selectedGender == 'female'
                                        ? Theme.of(context).colorScheme.primary
                                        : const Color(0xFF999999),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectGenderPopup(
                                      maleOnTap: () {
                                        updateGender(
                                          'male',
                                        );
                                        Navigator.pop(context);
                                      },
                                      femaleOnTap: () {
                                        updateGender(
                                          'female',
                                        );
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                              child: ImageIcon(
                                size: 20,
                                color: Theme.of(context).colorScheme.secondary,
                                const AssetImage(
                                  'assets/icons/arrow.png',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Gaps.hGap15,
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            countryListTheme: CountryListThemeData(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              textStyle: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              inputDecoration: InputDecoration(
                                hintText: 'Search Country',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF999999),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF4F4F4),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            onSelect: (Country country) {
                              setState(
                                () {
                                  selectedCountry = country.name;
                                  selectedCountryFlag =
                                      country.flagEmoji; // Get flag emoji
                                  _countryController.text =
                                      country.name; // Set country name
                                },
                              );
                            },
                          );
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _countryController,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: ImageIcon(
                                  size: 24,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  const AssetImage(
                                    'assets/icons/arrow.png',
                                  ),
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: selectedCountryFlag != null
                                    ? Text(
                                        selectedCountryFlag!,
                                        style: const TextStyle(fontSize: 24),
                                      )
                                    : Image.asset(
                                        'assets/icons/flag.png',
                                        width: 24,
                                        height: 24,
                                      ),
                              ),
                              hintText: 'Select Country',
                              hintStyle: const TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF999999),
                              ),
                              fillColor: const Color(0xFFF4F4F4),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _passwordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/lock.png',
                        hintText: 'Password',
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _confirmPasswordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/lock.png',
                        hintText: 'Confirm Password',
                      ),
                      Gaps.hGap15,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  agreeToTerms = !agreeToTerms;
                                },
                              );
                            },
                            child: agreeToTerms
                                ? ImageIcon(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    const AssetImage(
                                      'assets/icons/check.png',
                                    ),
                                  )
                                : const ImageIcon(
                                    color: Color(
                                      0xFFE8ECF4,
                                    ),
                                    AssetImage(
                                      'assets/icons/uncheck.png',
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'By using this app, you agree to our ',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _launchWebsite(
                              'https://teensplashevents.com/privacy_app.php',
                              context,
                            ),
                            child: Text(
                              'Privacy policy',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap40,
                      AppPrimaryButton(
                        text: 'Next',
                        onTap: () {
                          if (_nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter your name',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_emailController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter your email',
                                ),
                              ),
                            );
                            return;
                          }
                          if (selectedCountry!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select your country',
                                ),
                              ),
                            );
                            return;
                          }
                          if (selectedGender.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select your gender',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_passwordController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter your password',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Passwords do not match',
                                ),
                              ),
                            );
                            return;
                          }
                          if (agreeToTerms == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please agree to our privacy policy',
                                ),
                              ),
                            );
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  VerifyIdcardScreen(
                                name: _nameController.text,
                                email: _emailController.text,
                                gender: selectedGender,
                                country: selectedCountry.toString(),
                                countryFlag: selectedCountryFlag.toString(),
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                                isPrivacyPolicyAccepted: agreeToTerms,
                              ),
                            ),
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
