import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/views/monday_offer_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class ViewMoreMondayOffers extends StatefulWidget {
  const ViewMoreMondayOffers({super.key});

  @override
  State<ViewMoreMondayOffers> createState() => _ViewMoreMondayOffersState();
}

class _ViewMoreMondayOffersState extends State<ViewMoreMondayOffers> {
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

  Future<void> _refresh() async {
    adminBloc.add(
      GetMondayOffers(),
    );
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
          title: 'Major Minors Monday Offers',
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
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    final currentDate = DateFormat('yyyy-MM-dd').format(
                      DateTime.now(),
                    );

                    final filteredMondayOffers = adminBloc.mondayOffers.where(
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
                        : RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView.builder(
                              itemCount: filteredMondayOffers.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                                filteredMondayOffers[index]
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                      filteredMondayOffers[
                                                              index]
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
                                        filteredMondayOffers[index]
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
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
