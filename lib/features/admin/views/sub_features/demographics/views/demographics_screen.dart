import 'package:flutter/material.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/age_groups.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/app_usage_metrics.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/conversion_rate.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/country_groups.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/gender_groups.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/interests_prefered_coupons.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/number_of_coupons_redeemed.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/preffered_days.dart';
import 'package:teen_splash/features/admin/views/sub_features/demographics/widgets/spending_habits.dart';
import 'package:teen_splash/utils/gaps.dart';

class DemographicsScreen extends StatefulWidget {
  const DemographicsScreen({super.key});

  @override
  State<DemographicsScreen> createState() => _DemographicsScreenState();
}

class _DemographicsScreenState extends State<DemographicsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this); // 8 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 55,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFffffff,
            ),
            borderRadius: BorderRadius.circular(
              05,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Demographics',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color(
                    0xFF131313,
                  ),
                ),
              ),
              Gaps.hGap20,
              TabBar(
                dividerColor: Colors.grey[200],
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context)
                    .colorScheme
                    .primary, // Line indicator color
                indicatorWeight: 3, // Thickness of the line
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: "Age Groups"),
                  Tab(text: "Gender"),
                  Tab(text: "Country"),
                  Tab(text: "App Usage Metrics"),
                  Tab(text: "Conversion Rate"),
                  Tab(text: "Coupon's Redeemed"),
                  Tab(text: "Preferred Days of Activity"),
                  Tab(text: "Interests/Preferences"),
                  Tab(text: "Spending Habits"),
                ],
              ),
              Gaps.hGap20,
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AgeGroups(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GenderGroups(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CountryGroups(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppUsageMetrics(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConversionRate(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NumberofCouponRedeemed(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrefferedDays(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InterestsAndPreferences(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpendingHabits(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
