import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/featured_offer_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class ViewMoreFeaturedOffers extends StatefulWidget {
  const ViewMoreFeaturedOffers({super.key});

  @override
  State<ViewMoreFeaturedOffers> createState() => _ViewMoreFeaturedOffersState();
}

class _ViewMoreFeaturedOffersState extends State<ViewMoreFeaturedOffers> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.featuredOffers.isEmpty) {
      adminBloc.add(
        GetFeaturedOffers(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final adminBloc = context.read<AdminBloc>();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Featured Offers',
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, state) {
                          if (state is GettingFeaturedOffers) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetFeaturedOffersFailed) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return adminBloc.featuredOffers.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No offers',
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: adminBloc.featuredOffers.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
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
                                                    featuredOffer: adminBloc
                                                        .featuredOffers[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 12.0,
                                              ),
                                              width: double.infinity,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  8.0,
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    adminBloc
                                                            .featuredOffers[
                                                                index]
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
                                                      horizontal: 8,
                                                      vertical: 3,
                                                    ),
                                                    color:
                                                        const Color(0xFFEF589F),
                                                    child: Text(
                                                      adminBloc
                                                                  .featuredOffers[
                                                                      index]
                                                                  .discountType ==
                                                              'Cash Discount'
                                                          ? '\$${adminBloc.featuredOffers[index].discount ?? ''} off'
                                                          : '${adminBloc.featuredOffers[index].discount ?? ''}% off',
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      adminBloc.add(
                                                        AddFavouriteFeaturedOffer(
                                                          adminBloc
                                                              .featuredOffers[
                                                                  index]
                                                              .offerId
                                                              .toString(),
                                                          userId,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
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
                                                        adminBloc
                                                                .featuredOffers[
                                                                    index]
                                                                .isFavorite!
                                                                .contains(
                                                                    userId)
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_outline,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Gaps.hGap05,
                                          Text(
                                            adminBloc.featuredOffers[index]
                                                    .businessName ??
                                                '',
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 14,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
