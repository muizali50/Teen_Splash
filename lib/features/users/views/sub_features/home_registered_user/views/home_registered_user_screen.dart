import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/chat_room_screen.dart';
import 'package:teen_splash/features/users/views/favorites_screen.dart';
import 'package:teen_splash/features/users/views/offers_history_screen.dart';
import 'package:teen_splash/features/users/views/settings_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/clothing_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer_row.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/finanicial_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/food_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/features/users/views/terms_and_conditions_screen.dart';
import 'package:teen_splash/features/users/views/top_teens_screen.dart';
import 'package:teen_splash/features/users/views/view_more_monday_offers.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:teen_splash/widgets/search_field.dart';

class HomeRegisteredUserScreen extends StatefulWidget {
  const HomeRegisteredUserScreen({super.key});

  @override
  State<HomeRegisteredUserScreen> createState() =>
      _HomeRegisteredUserScreenState();
}

class _HomeRegisteredUserScreenState extends State<HomeRegisteredUserScreen>
    with TickerProviderStateMixin {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.mondayOffers.isEmpty) {
      adminBloc.add(
        GetMondayOffers(),
      );
    }
    super.initState();
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Builder(
                builder: (context) {
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
                },
              ),
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
                            const ChatRoomScreen(),
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
                    height: 55,
                    width: 55,
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
                          fontSize: 19,
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
                          fontSize: 19,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/history.png',
                    title: 'Offers History',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const OffersHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/setting.png',
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  Gaps.hGap15,
                  Divider(
                    color: const Color(0xFF000000).withOpacity(0.1),
                  ),
                  Gaps.hGap15,
                  DrawerRow(
                    iconImage: 'assets/icons/ranking.png',
                    title: 'Top Teens',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const TopTeensScreen(),
                        ),
                      );
                    },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const TermsAndConditionsScreen(),
                        ),
                      );
                    },
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
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            height: 200,
                            width: 386,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Logout?',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Gaps.hGap10,
                                const Text(
                                  textAlign: TextAlign.center,
                                  'Do you really want to logout your profile?',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                                Gaps.hGap15,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 106,
                                      child: AppPrimaryButton(
                                        hintTextColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        isBorderColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        isBorder: true,
                                        text: 'Cancel',
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 106,
                                      child: AppPrimaryButton(
                                        isPrimaryColor: true,
                                        text: 'Logout',
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
                            fontSize: 19,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.hGap50,
                  Gaps.hGap30,
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
                        Gaps.hGap50,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 110,
                          child: BlocBuilder<AdminBloc, AdminState>(
                            builder: (context, state) {
                              final currentDate =
                                  DateFormat('yyyy-MM-dd').format(
                                DateTime.now(),
                              );

                              final filteredMondayOffers =
                                  adminBloc.mondayOffers.where(
                                (offer) {
                                  final isDateValid = offer.date == currentDate;

                                  return isDateValid;
                                },
                              ).toList();
                              if (state is GettingMondayOffers) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is GetMondayOffersFailed) {
                                return Center(
                                  child: Text(state.message),
                                );
                              }
                              return filteredMondayOffers.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No offers',
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: filteredMondayOffers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (
                                                        context,
                                                      ) =>
                                                          MondayOfferDetailsScreen(
                                                        mondayOffer:
                                                            filteredMondayOffers[
                                                                index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 6.0,
                                                  ),
                                                  width: 131,
                                                  height: 89,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.0,
                                                    ),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        filteredMondayOffers[
                                                                    index]
                                                                .image ??
                                                            '',
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 4,
                                                          vertical: 2,
                                                        ),
                                                        color: const Color(
                                                            0xFFEF589F),
                                                        child: Text(
                                                          filteredMondayOffers[
                                                                          index]
                                                                      .discountType ==
                                                                  'Cash Discount'
                                                              ? '\$${filteredMondayOffers[index].discount ?? ''} off'
                                                              : '${filteredMondayOffers[index].discount ?? ''}% off',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .surface,
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          5.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .surface
                                                              .withOpacity(0.9),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          size: 10,
                                                          Icons.favorite,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Gaps.hGap05,
                                              Text(
                                                filteredMondayOffers[index]
                                                        .businessName ??
                                                    '',
                                                style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
              Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 158,
                  child: Image.asset('assets/images/card.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
