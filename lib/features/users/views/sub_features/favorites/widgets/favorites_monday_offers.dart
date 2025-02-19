import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class FavoritesMondayOffers extends StatefulWidget {
  const FavoritesMondayOffers({super.key});

  @override
  State<FavoritesMondayOffers> createState() => _FavoritesMondayOffersState();
}

class _FavoritesMondayOffersState extends State<FavoritesMondayOffers> {
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

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final adminBloc = context.read<AdminBloc>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monday Offers',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Gaps.hGap20,
          BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              final filteredMondayOffers = adminBloc.mondayOffers
                  .where(
                    (offer) => offer.isFavorite?.contains(userId) ?? false,
                  )
                  .toList();
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
                      child: Text('No Favorites Offer'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMondayOffers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            filteredMondayOffers[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 12.0,
                                  ),
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        filteredMondayOffers[index].image ?? '',
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        color: const Color(0xFFEF589F),
                                        child: Text(
                                          filteredMondayOffers[index]
                                                      .discountType ==
                                                  'Cash Discount'
                                              ? '\$${filteredMondayOffers[index].discount ?? ''} off'
                                              : '${filteredMondayOffers[index].discount ?? ''}% off',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
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
                                            AddFavouriteMondayOffer(
                                              filteredMondayOffers[index]
                                                  .offerId
                                                  .toString(),
                                              userId,
                                            ),
                                          );
                                        },
                                        child: Container(
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
                                            filteredMondayOffers[index]
                                                    .isFavorite!
                                                    .contains(userId)
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
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
                                filteredMondayOffers[index].businessName ?? '',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
