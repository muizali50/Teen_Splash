import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/views/coupons_screen.dart';
import 'package:teen_splash/features/users/views/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/views/home_registered_user_screen.dart';
import 'package:teen_splash/features/users/views/notifications_screen.dart';
import 'package:teen_splash/features/users/views/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeRegisteredUserScreen(),
    const CouponsScreen(),
    const EventScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

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
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.local_offer, title: 'Coupons'),
          TabItem(icon: Icons.calendar_today, title: ''),
          TabItem(icon: Icons.notifications, title: 'Notifications'),
          TabItem(icon: Icons.person, title: 'Profile'),
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
