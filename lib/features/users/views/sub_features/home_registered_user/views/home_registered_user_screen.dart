import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/clothing_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/events_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/finanicial_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/food_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/widgets/membership_card.dart';
import 'package:teen_splash/features/users/views/view_more_monday_offers.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isMenyIcon: true,
          isChatIcon: true,
          isTittle: true,
          title: 'Home',
        ),
      ),
      drawer: const Drawer(
        child: DrawerWidget(
          isGuest: false,
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
              const Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: Center(
                  child: MembershipCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
