import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final bool isGuest;
  const UpdatePasswordScreen({
    required this.isGuest,
    super.key,
  });

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
    final userBloc = context.watch<UserBloc>();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Update Password',
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
                child: widget.isGuest
                    ? Center(
                        child: Text('This screen is restricted for guests'),
                      )
                    : SingleChildScrollView(
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
                            BlocConsumer<UserBloc, UserState>(
                              listener: (context, state) {
                                if (state is ChangePasswordSuccess) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Password changed successfully',
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else if (state is ChangePasswordFailure) {
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
                                if (state is ChangePasswordLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return AppPrimaryButton(
                                  text: 'Update',
                                  onTap: () {
                                    if (_currentPasswordController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please enter your current password',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (_newPasswordController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please enter your new password',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (_newPasswordController.text !=
                                        _confirmNewPasswordController.text) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Passwords do not match',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    userBloc.add(
                                      ChangePassword(
                                        currentPassword:
                                            _currentPasswordController.text,
                                        newPassword:
                                            _newPasswordController.text,
                                        confirmNewPassword:
                                            _confirmNewPasswordController.text,
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
