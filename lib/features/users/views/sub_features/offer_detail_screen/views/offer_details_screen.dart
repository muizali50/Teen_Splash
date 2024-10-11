import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/offer_detail_screen/widgets/offer_redeemed.dart';
import 'package:teen_splash/features/users/views/sub_features/offer_detail_screen/widgets/redeem_offer.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 227,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1522158637959-30385a09e0da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                      InkWell(
                        onTap: () {},
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
                              Icons.favorite,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
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
                    Text(
                      'ABC Restaurant',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
                        const Text(
                          'Street 123, Holetown, Barbados.',
                          style: TextStyle(
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
                    Gaps.hGap15,
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.',
                      style: TextStyle(
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
                            child: RedeemOfferPopup(
                              redeemOnTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: OfferRedeemedDialog(
                                      dismissOnTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              cancelOnTap: () {
                                Navigator.pop(context);
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
    );
  }
}
