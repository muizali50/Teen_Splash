import 'package:flutter/material.dart';
import 'package:teen_splash/features/admin/views/all_coupons.dart';
import 'package:teen_splash/features/admin/views/all_events_screen.dart';
import 'package:teen_splash/features/admin/views/all_featured_offers.dart';
import 'package:teen_splash/features/admin/views/all_highlighted_sponsors.dart';
import 'package:teen_splash/features/admin/views/all_monday_offers.dart';
import 'package:teen_splash/features/admin/views/all_push_notification_screen.dart';
import 'package:teen_splash/features/admin/views/all_surveys_screen.dart';
import 'package:teen_splash/features/admin/views/all_teen_businesses.dart';
import 'package:teen_splash/features/admin/views/all_ticker_notification_screen.dart';
import 'package:teen_splash/features/admin/views/all_water_sponsors_screen.dart';
import 'package:teen_splash/features/admin/views/restricted_words_screen.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/views/demographics_screen.dart';
import 'package:teen_splash/features/admin/views/sub_features/dashborad/widgets/dashboard_fields.dart';
import 'package:teen_splash/features/admin/views/verify_users_screen.dart';
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
    const AllWaterSponsor(),
    const DemographicsScreen(),
    const AllTickerNotification(),
    const AllPushNotification(),
    const AllSurveysScreen(),
    const AllEventsScreen(),
    const VerifyUsers(),
    const AllTeenBusinesses(),
    const RestrictedWordsScreen(),
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
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(4),
                    iconColor: _selectedIndex == 4 ? 0xFF000000 : 0xFFffffff,
                    title: 'Water Sponsors',
                    titleColor: _selectedIndex == 4 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 4 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(5),
                    iconColor: _selectedIndex == 5 ? 0xFF000000 : 0xFFffffff,
                    title: 'Demographics',
                    titleColor: _selectedIndex == 5 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 5 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(6),
                    iconColor: _selectedIndex == 6 ? 0xFF000000 : 0xFFffffff,
                    title: 'Ticker Notification',
                    titleColor: _selectedIndex == 6 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 6 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(7),
                    iconColor: _selectedIndex == 7 ? 0xFF000000 : 0xFFffffff,
                    title: 'Push Notification',
                    titleColor: _selectedIndex == 7 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 7 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(8),
                    iconColor: _selectedIndex == 8 ? 0xFF000000 : 0xFFffffff,
                    title: 'Surveys',
                    titleColor: _selectedIndex == 8 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 8 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(9),
                    iconColor: _selectedIndex == 9 ? 0xFF000000 : 0xFFffffff,
                    title: 'Events',
                    titleColor: _selectedIndex == 9 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 9 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/person.png',
                    onTap: () => _onItemTapped(10),
                    iconColor: _selectedIndex == 10 ? 0xFF000000 : 0xFFffffff,
                    title: 'Members Information',
                    titleColor: _selectedIndex == 10 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 10 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(11),
                    iconColor: _selectedIndex == 11 ? 0xFF000000 : 0xFFffffff,
                    title: 'Teen Businesses',
                    titleColor: _selectedIndex == 11 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 11 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: 'assets/icons/offer.png',
                    onTap: () => _onItemTapped(12),
                    iconColor: _selectedIndex == 12 ? 0xFF000000 : 0xFFffffff,
                    title: 'Restricted Words',
                    titleColor: _selectedIndex == 12 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 12 ? 0xFFffffff : 0xFF000000,
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
