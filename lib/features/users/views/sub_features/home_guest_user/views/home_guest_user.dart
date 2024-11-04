import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/views/chat_room_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/clothing_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer_row.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/finanicial_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/food_screen.dart';
import 'package:teen_splash/features/users/views/view_more_monday_offers.dart';
import 'package:teen_splash/utils/gaps.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ImageIcon(
                        color: Theme.of(context).colorScheme.secondary,
                        const AssetImage(
                          'assets/icons/menu.png',
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            const ChatRoomScreen(
                              isGuest: true,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ImageIcon(
                        color: Theme.of(context).colorScheme.secondary,
                        const AssetImage(
                          'assets/icons/chat.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            'Home',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(
                          0xFFFFD700,
                        ),
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@aryas',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      const Text(
                        'Barbados 🇧🇧 ',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF999999,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gaps.hGap20,
            Divider(
              color: const Color(0xFF000000).withOpacity(0.1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  Gaps.hGap20,
                  DrawerRow(
                    iconImage: 'assets/icons/heart.png',
                    title: 'Favourites',
                    onTap: () {},
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/history.png',
                    title: 'Offers History',
                    onTap: () {},
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/setting.png',
                    title: 'Settings',
                    onTap: () {},
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/ranking.png',
                    title: 'Top Teens',
                    onTap: () {},
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/about.png',
                    title: 'About',
                    onTap: () {},
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/more.png',
                    title: 'Terms & Conditions',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                bottom: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        ImageIcon(
                          color: Color(0xFFE50000),
                          AssetImage(
                            'assets/icons/logout.png',
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFE50000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  const Text(
                    'Version 20.01.0',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            )
          ],
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
                    onPressed: () {},
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
                    Row(
                      children: [
                        Text(
                          'Major Minors Monday Offers',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    const ViewMoreMondayOffers(),
                              ),
                            );
                          },
                          child: Text(
                            'View More >',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 6.0,
                                  ),
                                  width: 131,
                                  height: 89,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1398&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        color: const Color(0xFFEF589F),
                                        child: Text(
                                          '20% off',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(
                                          5.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface
                                              .withOpacity(0.9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          size: 10,
                                          Icons.favorite,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.hGap05,
                                Text(
                                  'ABC Restaurant',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Gaps.hGap15,
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
