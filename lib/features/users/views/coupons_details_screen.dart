import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/widgets/horizontal_dashed_line.dart';
import 'package:teen_splash/features/users/views/sub_features/offer_detail_screen/widgets/redeem_offer.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CouponsDetailsScreen extends StatefulWidget {
  const CouponsDetailsScreen({super.key});

  @override
  State<CouponsDetailsScreen> createState() => _CouponsDetailsScreenState();
}

class _CouponsDetailsScreenState extends State<CouponsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
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
                    child: ImageIcon(
                      color: Theme.of(context).colorScheme.secondary,
                      const AssetImage('assets/icons/back.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'My Coupons',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
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
                    children: [
                      TicketWidget(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: double.infinity,
                        height: 570,
                        isCornerRounded: true,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            1.0,
                          ),
                          child: TicketWidget(
                            color: Theme.of(context).colorScheme.surface,
                            width: double.infinity,
                            height: 570,
                            isCornerRounded: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 86,
                                  width: 86,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/cheezious.png',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Little Caesars Pizza',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '20% Off',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 34,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                Gaps.hGap10,
                                SizedBox(
                                  height: 44,
                                  width: 164,
                                  child: AppPrimaryButton(
                                    text: 'Redeem',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: RedeemOfferPopup(
                                            redeemOnTap: () {},
                                            cancelOnTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                HorizontalDashedLine(
                                  width: 300,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  dashWidth: 5,
                                  dashHeight: 0.5,
                                  dashSpace: 5,
                                ),
                                Gaps.hGap20,
                                Container(
                                  height: 117,
                                  width: 117,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/qrcode.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MD524BGDGD8552',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Container(
                                      height: 16,
                                      width: 16,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/icons/copy.png',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Valid until: 4/10/2024',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.5,
                                    vertical: 8.0,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFCED),
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(
                                        0xFFFFD700,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/icons/info.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      SizedBox(
                                        width: 230,
                                        child: Text(
                                          'Scan the code below in order to apply the coupon to the order Or tap the code to get the numeric code, and type it manually.',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
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
