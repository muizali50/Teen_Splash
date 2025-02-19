import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/widgets/offer_redeemed.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/widgets/redeem_offer.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class MondayOfferDetailsScreen extends StatefulWidget {
  final MondayOffersModel mondayOffer;
  const MondayOfferDetailsScreen({
    required this.mondayOffer,
    super.key,
  });

  @override
  State<MondayOfferDetailsScreen> createState() =>
      _MondayOfferDetailsScreenState();
}

class _MondayOfferDetailsScreenState extends State<MondayOfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
    final String userId = FirebaseAuth.instance.currentUser!.uid;

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
                    widget.mondayOffer.image.toString(),
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
                        BlocBuilder<AdminBloc, AdminState>(
                          builder: (context, state) {
                            bool isFavorite =
                                widget.mondayOffer.isFavorite!.contains(userId);

                            return GestureDetector(
                              onTap: () {
                                context.read<AdminBloc>().add(
                                      AddFavouriteMondayOffer(
                                        widget.mondayOffer.offerId.toString(),
                                        userId,
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
                                  child: Icon(
                                    size: 27,
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                  widget.mondayOffer.businessLogo.toString(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.mondayOffer.businessName.toString(),
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
                            widget.mondayOffer.address.toString(),
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
                        widget.mondayOffer.offerName.toString(),
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Gaps.hGap15,
                      Text(
                        widget.mondayOffer.details.toString(),
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
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: BlocConsumer<AdminBloc, AdminState>(
                                listener: (context, state) {
                                  if (state is RedeemMondayOfferSuccess) {
                                    setState(
                                      () {
                                        offerCode = widget.mondayOffer
                                            .getUserOfferCode(userId);
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
                                          code: offerCode ?? 'Not Redeemed Yet',
                                          dismissOnTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  } else if (state is RedeemMondayOfferFailed) {
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
                                  if (state is ReedeemingMondayOffer) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return RedeemOfferPopup(
                                    redeemOnTap: () {
                                      adminBloc.add(
                                        RedeemMondayOffer(
                                          widget.mondayOffer.offerId.toString(),
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
