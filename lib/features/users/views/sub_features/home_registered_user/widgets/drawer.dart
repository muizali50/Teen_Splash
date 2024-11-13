import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/about_screen.dart';
import 'package:teen_splash/features/users/views/favorites_screen.dart';
import 'package:teen_splash/features/users/views/offers_history_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/settings_screen/views/settings_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer_row.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/views/terms_and_conditions_screen.dart';
import 'package:teen_splash/features/users/views/top_teens_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Row(
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
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
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
                    '@aryas',
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
                  const Text(
                    'Barbados 🇧🇧 ',
                    style: TextStyle(
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
                title: 'Top Teens',
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
              InkWell(
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
                          color: Theme.of(context).colorScheme.surface,
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
                                color: Theme.of(context).colorScheme.primary,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 106,
                                  child: AppPrimaryButton(
                                    hintTextColor:
                                        Theme.of(context).colorScheme.primary,
                                    isBorderColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    isBorder: true,
                                    text: 'Cancel',
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 106,
                                  child: AppPrimaryButton(
                                    isPrimaryColor: true,
                                    text: 'Logout',
                                    onTap: () {},
                                  ),
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
              ),
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
    );
  }
}
