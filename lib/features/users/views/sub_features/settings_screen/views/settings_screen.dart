import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/settings_screen/widgets/setting_row.dart';
import 'package:teen_splash/features/users/views/update_password_screen.dart';
import 'package:teen_splash/features/users/views/update_profile_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Settings',
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
                      Row(
                        children: [
                          Text(
                            'Push Notifications',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSwitched = value;
                                },
                              );
                            },
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            activeTrackColor:
                                Theme.of(context).colorScheme.primary,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                          ),
                        ],
                      ),
                      Gaps.hGap15,
                      Divider(
                        color: const Color(0xFF000000).withOpacity(0.1),
                      ),
                      Gaps.hGap15,
                      SettingRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  const UpdateProfileScreen(),
                            ),
                          );
                        },
                        title: 'Update Profile',
                        icon: 'assets/icons/forward.png',
                      ),
                      Gaps.hGap15,
                      Divider(
                        color: const Color(0xFF000000).withOpacity(0.1),
                      ),
                      Gaps.hGap15,
                      SettingRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  const UpdatePasswordScreen(),
                            ),
                          );
                        },
                        title: 'Update Password',
                        icon: 'assets/icons/forward.png',
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
