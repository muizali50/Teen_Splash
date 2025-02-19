import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/authentication/views/login_screen.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/about_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/favorites/views/favorites_screen.dart';
import 'package:teen_splash/features/users/views/offers_history_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/settings_screen/views/settings_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer_row.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/views/terms_and_conditions_screen.dart';
import 'package:teen_splash/features/users/views/top_teens_screen.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class DrawerWidget extends StatefulWidget {
  final bool? isGuest;
  const DrawerWidget({
    super.key,
    this.isGuest,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (widget.isGuest == false) {
      if (userProvider.user == null) {
        authenticationBloc.add(
          const GetUser(),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 20.0,
              right: 20.0,
            ),
            child: widget.isGuest == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Guest Mode',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                : Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      return Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
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
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.user?.name ?? '',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                '${userProvider.user?.country ?? ''} ${userProvider.user?.countryFlag ?? ''}',
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xFF999999,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
          Gaps.hGap20,
          Divider(
            color: const Color(0xFF000000).withOpacity(0.1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                Gaps.hGap20,
                DrawerRow(
                  iconImage: 'assets/icons/heart.png',
                  title: 'Favourites',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const FavoritesScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                DrawerRow(
                  iconImage: 'assets/icons/history.png',
                  title: 'Offers History',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const OffersHistoryScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                DrawerRow(
                  iconImage: 'assets/icons/setting.png',
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const SettingsScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                DrawerRow(
                  iconImage: 'assets/icons/ranking.png',
                  title: 'Teen Businesses',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const TopTeensScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                DrawerRow(
                  iconImage: 'assets/icons/about.png',
                  title: 'About',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const AboutScreen(),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                DrawerRow(
                  iconImage: 'assets/icons/more.png',
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const TermsAndConditionsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isGuest == true
                    ? const SizedBox()
                    : widget.isGuest == false
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    height: 200,
                                    width: 386,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Logout?',
                                          style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Gaps.hGap10,
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'Do you really want to logout your profile?',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                        Gaps.hGap15,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: 106,
                                              child: AppPrimaryButton(
                                                hintTextColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                isBorderColor: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                isBorder: true,
                                                text: 'Cancel',
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            BlocConsumer<UserBloc, UserState>(
                                              listener: (context, state) {
                                                if (state is LoggedOut) {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (
                                                        context,
                                                      ) =>
                                                          const LoginScreen(),
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else if (state
                                                    is LogOutFailed) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        state.message,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state is LoggingOut) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return SizedBox(
                                                  height: 50,
                                                  width: 106,
                                                  child: AppPrimaryButton(
                                                    isPrimaryColor: true,
                                                    text: 'Logout',
                                                    onTap: () {
                                                      userBloc.add(
                                                        LogOut(),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                ImageIcon(
                                  color: Color(0xFFE50000),
                                  AssetImage(
                                    'assets/icons/logout.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFE50000),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                Gaps.hGap15,
                Divider(
                  color: const Color(0xFF000000).withOpacity(0.1),
                ),
                Gaps.hGap15,
                const Text(
                  'Version 20.01.0',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
