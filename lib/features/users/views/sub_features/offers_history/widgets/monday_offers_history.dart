import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class MondayOffersHistoryScreen extends StatefulWidget {
  const MondayOffersHistoryScreen({super.key});

  @override
  State<MondayOffersHistoryScreen> createState() =>
      _MondayOffersHistoryScreenState();
}

class _MondayOffersHistoryScreenState extends State<MondayOffersHistoryScreen> {
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
              final filteredMondayOffers = adminBloc.mondayOffers.where(
                (offer) {
                  final bool isClaimed =
                      offer.userIds?.contains(userId) ?? false;
                  final bool isExpired = offer.date != null &&
                      DateTime.tryParse(offer.date!)
                              ?.isBefore(DateTime.now()) ==
                          true;

                  return isClaimed || isExpired;
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
                      child: Text('No Offer'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMondayOffers.length,
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
                                      MondayOfferDetailsScreen(
                                    mondayOffer: filteredMondayOffers[index],
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
                                          filteredMondayOffers[index].image ??
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
                                            filteredMondayOffers[index]
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        filteredMondayOffers[index].offerName ??
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
                                        filteredMondayOffers[index]
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
                                        filteredMondayOffers[index]
                                                    .discountType ==
                                                'Cash Discount'
                                            ? '\$${filteredMondayOffers[index].discount ?? ''} off'
                                            : '${filteredMondayOffers[index].discount ?? ''}% off',
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
        ],
      ),
    );
  }
}
