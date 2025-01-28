import 'package:flutter/material.dart';
import 'package:teen_splash/features/authentication/views/sub_features/views/signup_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/clothing_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/finanicial_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/food_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/search_field.dart';

class HomeGuestUser extends StatefulWidget {
  const HomeGuestUser({super.key});

  @override
  State<HomeGuestUser> createState() => _HomeGuestUserState();
}

class _HomeGuestUserState extends State<HomeGuestUser>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isMenyIcon: true,
          isChatIcon: true,
          isTittle: true,
          title: 'Home',
          isGuest: true,
        ),
      ),
      drawer: const Drawer(
        child: DrawerWidget(
          isGuest: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  scale: 10,
                  'assets/images/logo2.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Are you a teen? ',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gaps.hGap50,
                    SearchField(
                      controller: searchController,
                    ),
                    Gaps.hGap20,
                    Container(
                      width: double.infinity,
                      height: 40,
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
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
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
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Food',
                          ),
                          Tab(
                            text: 'Clothing',
                          ),
                          Tab(
                            text: 'Events',
                          ),
                          Tab(
                            text: 'Financial',
                          ),
                        ],
                      ),
                    ),
                    // Gaps.hGap0,
                    SizedBox(
                      height: 500,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          FoodScreen(),
                          ClothingScreen(),
                          EventsScreen(),
                          FinanicialScreen(),
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
