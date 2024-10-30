import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/widgets/horizontal_dashed_line.dart';
import 'package:teen_splash/features/users/views/sub_features/monday_offer_detail_screen/widgets/redeem_offer.dart';
import 'package:teen_splash/model/coupon_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CouponsDetailsScreen extends StatefulWidget {
  final CouponModel? coupon;
  const CouponsDetailsScreen({
    required this.coupon,
    super.key,
  });

  @override
  State<CouponsDetailsScreen> createState() => _CouponsDetailsScreenState();
}

class _CouponsDetailsScreenState extends State<CouponsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        widget.coupon!.image.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  widget.coupon!.businessName.toString(),
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
                                  '${widget.coupon!.discount.toString()}% Off',
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
                                          child:
                                              BlocConsumer<UserBloc, UserState>(
                                            listener: (context, state) {
                                              if (state
                                                  is RedeemCouponSuccess) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Redeemed Successfully',
                                                    ),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              } else if (state
                                                  is RedeemCouponFailed) {
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
                                              if (state is ReedeemingCoupon) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return RedeemOfferPopup(
                                                redeemOnTap: () {
                                                  userBloc.add(
                                                    RedeemCoupom(
                                                      widget.coupon!.couponId
                                                          .toString(),
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
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
                                  'Valid until: ${widget.coupon!.validDate.toString()}',
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
