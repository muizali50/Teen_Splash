import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/events_photo_gallery.dart';
import 'package:teen_splash/features/users/views/featured_offer_details_screen.dart';
import 'package:teen_splash/features/users/views/highlighted_sponsors_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/widgets/membership_card.dart';
import 'package:teen_splash/features/users/views/view_more_featured_offers.dart';
import 'package:teen_splash/features/users/views/view_more_highlighted_sponsors.dart';
import 'package:teen_splash/features/users/views/view_more_monday_offers.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/model/sponsors_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/search_field.dart';

class HomeRegisteredUserScreen extends StatefulWidget {
  const HomeRegisteredUserScreen({super.key});

  @override
  State<HomeRegisteredUserScreen> createState() =>
      _HomeRegisteredUserScreenState();
}

class _HomeRegisteredUserScreenState extends State<HomeRegisteredUserScreen> {
  late final AdminBloc adminBloc;
  List<MondayOffersModel> filteredMondayOfferData = [];
  List<FeaturedOffersModel> filteredFeaturedOfferData = [];
  List<SponsorsModel> filterSponsorData = [];
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.mondayOffers.isEmpty) {
      adminBloc.add(
        GetMondayOffers(),
      );
    }
    if (adminBloc.featuredOffers.isEmpty) {
      adminBloc.add(
        GetFeaturedOffers(),
      );
    }
    if (adminBloc.sponsors.isEmpty) {
      adminBloc.add(
        GetSponsors(),
      );
    }

    searchController.addListener(
      _onSearchChanged,
    );
    super.initState();
  }

  void _onSearchChanged() {
    setState(
      () {
        _searchText = searchController.text;
        _filterMondayOffers();
        _filterFeaturedOffers();
        _filterSponsors();
      },
    );
  }

  void _filterMondayOffers() {
    if (_searchText.isEmpty) {
      filteredMondayOfferData = adminBloc.mondayOffers;
    } else {
      filteredMondayOfferData = adminBloc.mondayOffers
          .where(
            (offer) => offer.businessName!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void _filterFeaturedOffers() {
    if (_searchText.isEmpty) {
      filteredFeaturedOfferData = adminBloc.featuredOffers;
    } else {
      filteredFeaturedOfferData = adminBloc.featuredOffers
          .where(
            (offer) => offer.businessName!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void _filterSponsors() {
    if (_searchText.isEmpty) {
      filterSponsorData = adminBloc.sponsors;
    } else {
      filterSponsorData = adminBloc.sponsors
          .where(
            (offer) => offer.businessName!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                                  filteredMondayOfferData.isNotEmpty
                                      ? filteredMondayOfferData.where(
                                          (offer) {
                                            final isDateValid =
                                                offer.date == currentDate;

                                            return isDateValid;
                                          },
                                        ).toList()
                                      : adminBloc.mondayOffers.where(
                                          (offer) {
                                            final isDateValid =
                                                offer.date == currentDate;

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
                        Gaps.hGap05,
                        Row(
                          children: [
                            Text(
                              'Featured Offers',
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
                                        const ViewMoreFeaturedOffers(),
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
                              final featuredOffers =
                                  filteredFeaturedOfferData.isEmpty
                                      ? adminBloc.featuredOffers
                                      : filteredFeaturedOfferData;
                              if (state is GettingFeaturedOffers) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is GetFeaturedOffersFailed) {
                                return Center(
                                  child: Text(state.message),
                                );
                              }
                              return featuredOffers.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No offers',
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: featuredOffers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
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
                                                          FeaturedOfferDetailsScreen(
                                                        featuredOffer:
                                                            featuredOffers[
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
                                                        featuredOffers[index]
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
                                                          featuredOffers[index]
                                                                      .discountType ==
                                                                  'Cash Discount'
                                                              ? '\$${featuredOffers[index].discount ?? ''} off'
                                                              : '${featuredOffers[index].discount ?? ''}% off',
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
                                                featuredOffers[index]
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
                        Gaps.hGap05,
                        Row(
                          children: [
                            const Text(
                              'Highlighted Sponsors',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF36F21),
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
                                        const ViewMoreHighlightedSponsors(),
                                  ),
                                );
                              },
                              child: const Text(
                                'View More >',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFF36F21),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 110,
                          child: BlocBuilder<AdminBloc, AdminState>(
                            builder: (context, state) {
                              final sponsor = filterSponsorData.isNotEmpty
                                  ? filterSponsorData
                                  : adminBloc.sponsors;
                              if (state is GettingSponsor) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is GetSponsorFailed) {
                                return Center(
                                  child: Text(state.message),
                                );
                              }
                              return sponsor.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No sponsors',
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sponsor.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
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
                                                          HighlightedSponsorDetailsScreen(
                                                        sponsor: sponsor[index],
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
                                                        sponsor[index].image ??
                                                            '',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Gaps.hGap05,
                                              Text(
                                                sponsor[index].businessName ??
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
                        Gaps.hGap05,
                        Row(
                          children: [
                            Text(
                              'Event Photo Galleries',
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
                                        const EventsPhotoGallery(),
                                  ),
                                );
                              },
                              child: Text(
                                'View More >',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primary,
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
                                            'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gaps.hGap05,
                                    Text(
                                      'Little Caesars Pizza',
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
