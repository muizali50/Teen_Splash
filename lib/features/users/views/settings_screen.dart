import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/update_password_screen.dart';
import 'package:teen_splash/features/users/views/update_profile_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

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
            'Settings',
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
                      InkWell(
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
                        child: Row(
                          children: [
                            Text(
                              'Update Profile',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const Spacer(),
                            ImageIcon(
                              color: Theme.of(context).colorScheme.secondary,
                              const AssetImage(
                                'assets/icons/forward.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.hGap15,
                      Divider(
                        color: const Color(0xFF000000).withOpacity(0.1),
                      ),
                      Gaps.hGap15,
                      InkWell(
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
                        child: Row(
                          children: [
                            Text(
                              'Update Password',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const Spacer(),
                            ImageIcon(
                              color: Theme.of(context).colorScheme.secondary,
                              const AssetImage(
                                'assets/icons/forward.png',
                              ),
                            ),
                          ],
                        ),
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
