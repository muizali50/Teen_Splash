import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/offers_history/widgets/featured_offers_history.dart';
import 'package:teen_splash/features/users/views/sub_features/offers_history/widgets/monday_offers_history.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class OffersHistoryScreen extends StatefulWidget {
  const OffersHistoryScreen({super.key});

  @override
  State<OffersHistoryScreen> createState() => _OffersHistoryScreenState();
}

class _OffersHistoryScreenState extends State<OffersHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Offers History',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            38,
                          ),
                        ),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        labelColor: Theme.of(context).colorScheme.surface,
                        unselectedLabelColor: const Color(0xFF999999),
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        labelStyle: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: _tabController,
                        tabs: const [
                          Tab(text: "Monday Offers"),
                          Tab(text: "Featured Offers"),
                        ],
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          MondayOffersHistoryScreen(),
                          FeauturedOffersHistoryScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
