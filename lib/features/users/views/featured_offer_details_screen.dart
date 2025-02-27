import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/widgets/offer_redeemed.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/widgets/redeem_offer.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class FeaturedOfferDetailsScreen extends StatefulWidget {
  final FeaturedOffersModel featuredOffer;
  final bool isGuest;
  const FeaturedOfferDetailsScreen({
    required this.featuredOffer,
    required this.isGuest,
    super.key,
  });

  @override
  State<FeaturedOfferDetailsScreen> createState() =>
      _FeaturedOfferDetailsScreenState();
}

class _FeaturedOfferDetailsScreenState
    extends State<FeaturedOfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
    // Get user-specific offer code
    String? offerCode;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 227,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.featuredOffer.image.toString(),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 65,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                                  'assets/icons/back.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        widget.isGuest
                            ? const SizedBox()
                            : BlocBuilder<AdminBloc, AdminState>(
                                builder: (context, state) {
                                  String userId =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  bool isFavorite = widget
                                      .featuredOffer.isFavorite!
                                      .contains(userId);

                                  return GestureDetector(
                                    onTap: () {
                                      context.read<AdminBloc>().add(
                                            AddFavouriteFeaturedOffer(
                                              widget.featuredOffer.offerId
                                                  .toString(),
                                              userId,
                                            ),
                                          );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          size: 27,
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          32.0,
                        ),
                        topRight: Radius.circular(
                          32.0,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.featuredOffer.businessLogo.toString(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.featuredOffer.businessName.toString(),
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap15,
                      Row(
                        children: [
                          ImageIcon(
                            color: Theme.of(context).colorScheme.tertiary,
                            const AssetImage(
                              'assets/icons/location.png',
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            widget.featuredOffer.address.toString(),
                            style: const TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap20,
                      Text(
                        'Details',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        widget.featuredOffer.offerName.toString(),
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Gaps.hGap15,
                      Text(
                        widget.featuredOffer.details.toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      AppPrimaryButton(
                        text: 'Redeem Now',
                        onTap: () {
                          widget.isGuest
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'This feature is restricted for guests',
                                    ),
                                  ),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: BlocConsumer<AdminBloc, AdminState>(
                                      listener: (context, state) {
                                        final String userId = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        if (state
                                            is RedeemFeaturedOfferSuccess) {
                                          setState(
                                            () {
                                              setState(
                                                () {
                                                  List<String>? offerCodes =
                                                      widget.featuredOffer
                                                          .getUserOfferCodes(
                                                              userId);
                                                  offerCode = (offerCodes !=
                                                              null &&
                                                          offerCodes.isNotEmpty)
                                                      ? offerCodes.last
                                                      : null;
                                                },
                                              );
                                            },
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Redeemed Successfully',
                                              ),
                                            ),
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: OfferRedeemedDialog(
                                                code: offerCode ??
                                                    'Not Redeemed Yet',
                                                dismissOnTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          );
                                        } else if (state
                                            is RedeemFeaturedOfferFailed) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                state.message,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is ReedeemingFeaturedOffer) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return RedeemOfferPopup(
                                          redeemOnTap: () {
                                            adminBloc.add(
                                              RedeemFeauturedOffer(
                                                widget.featuredOffer.offerId
                                                    .toString(),
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ),
                                            );
                                          },
                                          cancelOnTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
