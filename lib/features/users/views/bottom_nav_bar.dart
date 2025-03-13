import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/events_screen/views/events_screen.dart';
import 'package:teen_splash/features/users/views/notifications_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/views/coupons_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_guest_user/views/home_guest_user.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/views/home_registered_user_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/views/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  final bool? isGuest;
  final String? payload;
  final bool? isNotification;
  final RemoteMessage? initialMessage;
  const BottomNavBar({
    this.isGuest,
    super.key,
    this.payload,
    this.isNotification,
    this.initialMessage,
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
    if (widget.isNotification == true || widget.initialMessage != null) {
      _selectedIndex = 3;
    }
    if (widget.isGuest ?? false) {
      _screens = [
        const HomeGuestUser(),
        const EventScreen(
          isGuest: true,
        ),
        const NotificationsScreen(
          isGuest: true,
        ),
      ];
    } else {
      _screens = [
        HomeRegisteredUserScreen(
          payload: widget.payload,
        ),
        const CouponsScreen(),
        const EventScreen(
          isGuest: false,
        ),
        const NotificationsScreen(
          isGuest: false,
        ),
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
      bottomNavigationBar: ConvexAppBar(
        // height: 60,
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
            title: '',
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
    );
  }
}
