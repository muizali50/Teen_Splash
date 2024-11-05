import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/coupons_details_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/coupons_screen/widgets/vertical_dashed_line.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.coupons.isEmpty) {
      adminBloc.add(
        GetCoupon(),
      );
    }
    super.initState();
  }

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
                      const AssetImage('assets/icons/menu.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Coupons',
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
                      BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, state) {
                          final currentDate = DateTime.now();
                          final dateFormat = DateFormat('yyyy-MM-dd');

                          final filteredCoupon = adminBloc.coupons.where(
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
                          if (state is GettingCoupon) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetCouponFailed) {
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
