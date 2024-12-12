import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/sub_features/widgets/select_gender_popup.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/user_provider.dart';
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
  late final AuthenticationBloc authenticationBloc;
  late final UserProvider userProvider;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? selectedCountry;
  String? selectedCountryFlag;
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
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }

    _nameController.text = userProvider.user!.name;
    _emailController.text = userProvider.user!.email;
    if (userProvider.user!.age != null) {
      _ageController.text = userProvider.user!.age ?? '';
    }
    if (userProvider.user!.gender != null) {
      selectedGender = userProvider.user!.gender ?? '';
    }
    if (userProvider.user!.country != null) {
      selectedCountry = userProvider.user!.country ?? '';
    }
    if (userProvider.user!.countryFlag != null) {
      selectedCountryFlag = userProvider.user!.countryFlag ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    final UserProvider userProvider = context.watch<UserProvider>();
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: userProvider.user?.picture == null ||
                                        userProvider.user!.picture!.isEmpty
                                    ? const AssetImage(
                                        'assets/images/user.png',
                                      )
                                    : NetworkImage(
                                        userProvider.user!.picture!,
                                      ) as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 75,
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UploadPictureLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );
                                    if (result != null) {
                                      userBloc.add(
                                        UploadPicture(
                                          result.files.single.path!,
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/edit.png',
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                      AppTextField(
                        controller: _ageController,
                        isPrefixIcon: true,
                        hintText: 'Age',
                        iconImageAddress: 'assets/icons/person.png',
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
                                  selectedCountryFlag = country.flagEmoji;
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
                              hintText: selectedCountry,
                              hintStyle: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.primary,
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
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is EditProfileSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Profile edited successfully',
                                ),
                              ),
                            );
                            Navigator.pop(
                              context,
                            );
                          } else if (state is EditProfileFailed) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.message,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is EditingProfile) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppPrimaryButton(
                            text: 'Update',
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
                              userBloc.add(
                                EditProfile(
                                  _nameController.text,
                                  _emailController.text,
                                  _ageController.text,
                                  selectedGender,
                                  selectedCountry.toString(),
                                  selectedCountryFlag.toString(),
                                ),
                              );
                            },
                          );
                        },
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
