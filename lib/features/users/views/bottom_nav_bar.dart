import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/events_screen.dart';
import 'package:teen_splash/features/users/views/notifications_screen.dart';
import 'package:teen_splash/features/users/views/profile_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/views/coupons_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_guest_user/views/home_guest_user.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/views/home_registered_user_screen.dart';

class BottomNavBar extends StatefulWidget {
  final bool? isGuest;
  const BottomNavBar({
    this.isGuest,
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    if (widget.isGuest ?? false) {
      _screens = [
        const HomeGuestUser(),
        const EventScreen(),
        const NotificationsScreen(),
      ];
    } else {
      _screens = [
        const HomeRegisteredUserScreen(),
        const CouponsScreen(),
        const EventScreen(),
        const NotificationsScreen(),
        const ProfileScreen(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ConvexAppBar(
            height: 60,
            items: [
              TabItem(
                fontFamily: 'OpenSans',
                activeIcon: ImageIcon(
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                  const AssetImage(
                    'assets/icons/select_home.png',
                  ),
                ),
                icon: const ImageIcon(
                  color: Color(0xFF9DB2CE),
                  AssetImage(
                    'assets/icons/unselect_home.png',
                  ),
                ),
                // title: 'Home',
              ),
              if (!(widget.isGuest ?? false))
                TabItem(
                  fontFamily: 'OpenSans',
                  activeIcon: ImageIcon(
                    color: Theme.of(context).colorScheme.secondary,
                    const AssetImage(
                      'assets/icons/select_ticket.png',
                    ),
                  ),
                  icon: const ImageIcon(
                    color: Color(0xFF9DB2CE),
                    AssetImage(
                      'assets/icons/unselect_ticket.png',
                    ),
                  ),
                  // title: 'Coupon',
                ),
              TabItem(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.tertiary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const ImageIcon(
                      color: Color(0xFFffffff),
                      AssetImage(
                        'assets/icons/calendar.png',
                      ),
                    ),
                  ],
                ),
                // title: '',
              ),
              TabItem(
                fontFamily: 'OpenSans',
                activeIcon: ImageIcon(
                  color: Theme.of(context).colorScheme.secondary,
                  const AssetImage(
                    'assets/icons/select_noti.png',
                  ),
                ),
                icon: const ImageIcon(
                  color: Color(0xFF9DB2CE),
                  AssetImage(
                    'assets/icons/unselect_noti.png',
                  ),
                ),
                // title: 'Notification',
              ),
              if (!(widget.isGuest ?? false))
                TabItem(
                  fontFamily: 'OpenSans',
                  activeIcon: ImageIcon(
                    color: Theme.of(context).colorScheme.secondary,
                    const AssetImage(
                      'assets/icons/select_profile.png',
                    ),
                  ),
                  icon: const ImageIcon(
                    color: Color(0xFF9DB2CE),
                    AssetImage(
                      'assets/icons/unselect_profile.png',
                    ),
                  ),
                  // title: 'Profile',
                ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary,
            activeColor: Theme.of(context).colorScheme.secondary,
            color: const Color(0xFF9DB2CE),
            initialActiveIndex: _selectedIndex,
            onTap: _onItemTapped,
            style: TabStyle.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
