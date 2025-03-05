import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/featured_offer_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class FeauturedOffersHistoryScreen extends StatefulWidget {
  const FeauturedOffersHistoryScreen({super.key});

  @override
  State<FeauturedOffersHistoryScreen> createState() =>
      _FeauturedOffersHistoryScreenState();
}

class _FeauturedOffersHistoryScreenState
    extends State<FeauturedOffersHistoryScreen> {
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

  Future<void> _refresh() async {
    adminBloc.add(
      GetFeaturedOffers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final adminBloc = context.read<AdminBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Offers',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Gaps.hGap20,
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                final filteredFeaturedOffers = adminBloc.featuredOffers
                    .where(
                      (offer) => offer.userIds?.contains(userId) ?? false,
                    )
                    .toList();

                if (state is GettingFeaturedOffers) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetFeaturedOffersFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return filteredFeaturedOffers.isEmpty
                    ? const Center(
                        child: Text('No Offer'),
                      )
                    : ListView.builder(
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredFeaturedOffers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        FeaturedOfferDetailsScreen(
                                      featuredOffer:
                                          filteredFeaturedOffers[index],
                                      isGuest: false,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 0),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                        right: 60,
                                        bottom: 60,
                                      ),
                                      height: 100,
                                      width: 103,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            filteredFeaturedOffers[index]
                                                    .image ??
                                                '',
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        height: 29,
                                        width: 29,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(
                                              0xFFFFD700,
                                            ),
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              filteredFeaturedOffers[index]
                                                      .businessLogo ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          filteredFeaturedOffers[index]
                                                  .offerName ??
                                              '',
                                          style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          filteredFeaturedOffers[index]
                                                  .businessName ??
                                              '',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                        Gaps.hGap10,
                                        Text(
                                          filteredFeaturedOffers[index]
                                                      .discountType ==
                                                  'Cash Discount'
                                              ? '\$${filteredFeaturedOffers[index].discount ?? ''} off'
                                              : '${filteredFeaturedOffers[index].discount ?? ''}% off',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF999999),
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
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
