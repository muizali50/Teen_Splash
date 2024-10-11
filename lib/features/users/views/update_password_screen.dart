import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ImageIcon(
                      color: Theme.of(context).colorScheme.secondary,
                      const AssetImage(
                        'assets/icons/back.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Update Password',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
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
                      const Text(
                        'Update your password to a strong one by using a mix of uppercase and lowercase letters, numbers, and special characters.',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999),
                        ),
                      ),
                      Gaps.hGap40,
                      AppTextField(
                        controller: _currentPasswordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/lock.png',
                        hintText: 'Current Password',
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _newPasswordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/lock.png',
                        hintText: 'New Password',
                      ),
                      Gaps.hGap15,
                      AppTextField(
                        controller: _confirmNewPasswordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        iconImageAddress: 'assets/icons/lock.png',
                        hintText: 'Confirm New Password',
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
