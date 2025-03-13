import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/settings_screen/widgets/setting_row.dart';
import 'package:teen_splash/features/users/views/update_password_screen.dart';
import 'package:teen_splash/features/users/views/update_profile_screen.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class SettingsScreen extends StatefulWidget {
  final bool isGuest;
  const SettingsScreen({
    required this.isGuest,
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AuthenticationBloc authenticationBloc;
  late final UserProvider userProvider;
  late bool isSwitched;

  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (!widget.isGuest) {
      if (userProvider.user == null) {
        authenticationBloc.add(
          const GetUser(),
        );
      }

      if (userProvider.user!.isPushNotification != null) {
        isSwitched = userProvider.user!.isPushNotification ?? false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final UserProvider userProvider = context.watch<UserProvider>();
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
                      if (!widget.isGuest)
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
                              value:
                                  userProvider.user?.isPushNotification ??
                                          false,
                              onChanged: (value) {
                                userBloc.add(
                                  TooglePushNotification(
                                    value,
                                  ),
                                );
                                setState(
                                  () {
                                    userProvider.user?.isPushNotification =
                                        value;
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
                      if (!widget.isGuest) Gaps.hGap15,
                      if (!widget.isGuest)
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
                                  UpdateProfileScreen(
                                isGuest: widget.isGuest,
                              ),
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
                                  UpdatePasswordScreen(
                                isGuest: widget.isGuest,
                              ),
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
