import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/coupons_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/widgets/vertical_dashed_line.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late final UserBloc userBloc;
  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    if (userBloc.coupons.isEmpty) {
      userBloc.add(
        GetUserCoupons(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isMenyIcon: true,
          isTittle: true,
          title: 'Coupons',
        ),
      ),
      drawer: const Drawer(
        child: DrawerWidget(
          isGuest: false,
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Coupons',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap20,
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          final currentDate = DateTime.now();
                          final dateFormat = DateFormat('yyyy-MM-dd');

                          final filteredCoupon = userBloc.coupons.where(
                            (coupon) {
                              final isUserNotRedeemed = !coupon.userIds!
                                  .contains(
                                      FirebaseAuth.instance.currentUser!.uid);

                              final isDateValid = coupon.validDate != null &&
                                  dateFormat
                                      .parse(coupon.validDate!)
                                      .isAfter(currentDate);

                              return isUserNotRedeemed && isDateValid;
                            },
                          ).toList();
                          if (state is GettingUserCoupon) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetUserCouponFailed) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return filteredCoupon.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No coupons',
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredCoupon.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                              context,
                                            ) =>
                                                CouponsDetailsScreen(
                                              coupon: filteredCoupon[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: TicketWidget(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          width: double.infinity,
                                          height: 124,
                                          isCornerRounded: true,
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                              1.0,
                                            ),
                                            child: TicketWidget(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              width: double.infinity,
                                              height: 124,
                                              isCornerRounded: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 30,
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    scale: 8,
                                                    filteredCoupon[index]
                                                            .image ??
                                                        '',
                                                  ),
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  Center(
                                                    child: Align(
                                                      child: VerticalDashedLine(
                                                        height: 100,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                        dashHeight: 10,
                                                        dashWidth: 0.5,
                                                        dashSpace: 4,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        filteredCoupon[index]
                                                                .businessName ??
                                                            '',
                                                        style: TextStyle(
                                                          fontFamily: 'Lexend',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ),
                                                      Gaps.hGap05,
                                                      Text(
                                                        filteredCoupon[index]
                                                                    .discountType ==
                                                                'Cash Discount'
                                                            ? '\$${filteredCoupon[index].discount ?? ''} off'
                                                            : '${filteredCoupon[index].discount ?? ''}% off',
                                                        style: TextStyle(
                                                          fontFamily: 'Lexend',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary,
                                                        ),
                                                      ),
                                                      Gaps.hGap05,
                                                      Text(
                                                        '${filteredCoupon[index].item ?? ''} Coupon',
                                                        style: TextStyle(
                                                          fontFamily: 'Lexend',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                        ),
                                                      ),
                                                      Gaps.hGap10,
                                                      Text(
                                                        'Valid until: ${filteredCoupon[index].validDate ?? ''}',
                                                        style: TextStyle(
                                                          fontFamily: 'Lexend',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
