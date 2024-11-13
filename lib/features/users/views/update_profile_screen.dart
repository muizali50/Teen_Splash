import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/authentication/views/sub_features/widgets/select_gender_popup.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? selectedCountry;
  String selectedGender = '';
  void updateGender(
    String gender,
  ) {
    setState(
      () {
        selectedGender = gender;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Update Profile',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
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
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(-4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 105,
                            width: 105,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(
                                  0xFFFFD700,
                                ),
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 75,
                            child: Container(
                              padding: const EdgeInsets.all(7.0),
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                color: Theme.of(context).colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/edit.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap40,
                      AppTextField(
                        controller: _nameController,
                        isPrefixIcon: true,
                        hintText: 'Name',
                        iconImageAddress: 'assets/icons/person.png',
                        prefixIconColor: Theme.of(context).colorScheme.tertiary,
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _emailController,
                        isPrefixIcon: true,
                        hintText: 'Email',
                        iconImageAddress: 'assets/icons/email.png',
                        prefixIconColor: Theme.of(context).colorScheme.tertiary,
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
                              color: Theme.of(context).colorScheme.tertiary,
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
                                  _countryController.text = country.name;
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
                                child: Image.asset(
                                  color: Theme.of(context).colorScheme.tertiary,
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
                      Gaps.hGap50,
                      AppPrimaryButton(
                        text: 'Update',
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
