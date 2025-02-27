import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/events_screen/widgets/past_events.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/sub_features/events_screen/widgets/upcomming_events.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class EventScreen extends StatefulWidget {
  final bool isGuest;
  const EventScreen({
    required this.isGuest,
    super.key,
  });

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
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
          isMenyIcon: true,
          isChatIcon: true,
          isTittle: true,
          title: 'Events',
          isGuest: true,
        ),
      ),
      drawer: Drawer(
        child: DrawerWidget(
          isGuest: widget.isGuest,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
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
                          Tab(text: "Upcoming Events"),
                          Tab(text: "Past Events"),
                        ],
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          UpcommingEvents(),
                          PastEvents(),
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
