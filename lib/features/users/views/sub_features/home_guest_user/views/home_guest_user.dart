import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/authentication/views/sub_features/views/signup_screen.dart';
import 'package:teen_splash/features/users/views/events_photo_gallery.dart';
import 'package:teen_splash/features/users/views/featured_offer_details_screen.dart';
import 'package:teen_splash/features/users/views/highlighted_sponsors_details_screen.dart';
import 'package:teen_splash/features/users/views/photo_gallery_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/view_more_featured_offers.dart';
import 'package:teen_splash/features/users/views/view_more_highlighted_sponsors.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/model/photo_gallery_model.dart';
import 'package:teen_splash/model/sponsors_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/search_field.dart';

class HomeGuestUser extends StatefulWidget {
  final String? payload;
  const HomeGuestUser({
    super.key,
    this.payload,
  });

  @override
  State<HomeGuestUser> createState() => _HomeGuestUserState();
}

class _HomeGuestUserState extends State<HomeGuestUser> {
  late final AdminBloc adminBloc;
  List<FeaturedOffersModel> filteredFeaturedOfferData = [];
  List<SponsorsModel> filterSponsorData = [];
  List<PhotoGalleryModel> filterPhotoGalleryData = [];
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

    if (adminBloc.photoGalleries.isEmpty) {
      adminBloc.add(
        GetPhotoGallery(),
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
        _filterFeaturedOffers();
        _filterSponsors();
        _filterPhotoGalleries();
      },
    );
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

  void _filterPhotoGalleries() {
    if (_searchText.isEmpty) {
      filterPhotoGalleryData = adminBloc.photoGalleries;
    } else {
      filterPhotoGalleryData = adminBloc.photoGalleries
          .where(
            (offer) => offer.name!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  Future<void> _refresh() async {
    adminBloc.add(
      GetFeaturedOffers(),
    );
    adminBloc.add(
      GetSponsors(),
    );
    adminBloc.add(
      GetPhotoGallery(),
    );
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
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
                                      const ViewMoreFeaturedOffers(
                                    isGuest: true,
                                  ),
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
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                                          featuredOffers[index],
                                                      isGuest: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
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
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    // Container(
                                                    //   padding:
                                                    //       const EdgeInsets.all(
                                                    //     5.0,
                                                    //   ),
                                                    //   decoration: BoxDecoration(
                                                    //     color: Theme.of(context)
                                                    //         .colorScheme
                                                    //         .surface
                                                    //         .withOpacity(0.9),
                                                    //     shape: BoxShape.circle,
                                                    //   ),
                                                    //   child: Icon(
                                                    //     size: 10,
                                                    //     Icons.favorite,
                                                    //     color: Theme.of(context)
                                                    //         .colorScheme
                                                    //         .secondary,
                                                    //   ),
                                                    // ),
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
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                              sponsor[index].businessName ?? '',
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
                        child: BlocBuilder<AdminBloc, AdminState>(
                          builder: (context, state) {
                            final photoGallery =
                                filterPhotoGalleryData.isNotEmpty
                                    ? filterPhotoGalleryData
                                    : adminBloc.photoGalleries;
                            if (state is GettingPhotoGallery) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetPhotoGalleryFailed) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            return photoGallery.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No Photo Gallery',
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: photoGallery.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                                        PhotoGalleryDetailsScreen(
                                                      photoGallery:
                                                          photoGallery[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                      photoGallery[index]
                                                              .image ??
                                                          '',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gaps.hGap05,
                                            Text(
                                              photoGallery[index].name ?? '',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
