import 'package:flutter/material.dart';
import 'package:teen_splash/features/admin/views/all_coupons.dart';
import 'package:teen_splash/features/admin/views/all_featured_offers.dart';
import 'package:teen_splash/features/admin/views/all_highlighted_sponsors.dart';
import 'package:teen_splash/features/admin/views/all_monday_offers.dart';
import 'package:teen_splash/features/admin/views/sub_features/dashborad/widgets/dashboard_fields.dart';
import 'package:teen_splash/utils/gaps.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const AllMondayOffers(),
    const AllFeaturedOffers(),
    const AllHighlightedSponsor(),
    const AllCoupons(),
  ];

  void _onItemTapped(
    int index,
  ) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 305,
            color: const Color(
              0xFF000000,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gaps.hGap35,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(0),
                    iconColor: _selectedIndex == 0 ? 0xFF000000 : 0xFFffffff,
                    title: 'Monday Offers',
                    titleColor: _selectedIndex == 0 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 0 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(1),
                    iconColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                    title: 'Featured Offers',
                    titleColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 1 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(2),
                    iconColor: _selectedIndex == 2 ? 0xFF000000 : 0xFFffffff,
                    title: 'Highlighted Sponsors',
                    titleColor: _selectedIndex == 2 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 2 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/unselect_ticket.png',
                    onTap: () => _onItemTapped(3),
                    iconColor: _selectedIndex == 3 ? 0xFF000000 : 0xFFffffff,
                    title: 'Coupons',
                    titleColor: _selectedIndex == 3 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 3 ? 0xFFffffff : 0xFF000000,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFffffff),
              child: _screens.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
