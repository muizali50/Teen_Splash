import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/views/coupons_screen.dart';
import 'package:teen_splash/features/users/views/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/views/home_registered_user_screen.dart';
import 'package:teen_splash/features/users/views/notifications_screen.dart';
import 'package:teen_splash/features/users/views/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeRegisteredUserScreen(),
    const CouponsScreen(),
    const EventScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    // Ignore taps on the center button (index 2)
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
          TabItem(icon: Icons.calendar_today, title: ''), // Fixed center button
          TabItem(icon: Icons.notifications, title: 'Notifications'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        activeColor:
            Theme.of(context).colorScheme.secondary, // For selected items
        color: const Color(0xFF9DB2CE), // Default color for non-selected items
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
        style: TabStyle.fixed, // Show label only for selected tab
        elevation: 0,
        // centerButtonBackgroundColor: Colors.red, // Fixed color for calendar button
      ),
    );
  }
}
