import 'package:flutter/material.dart';
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (
                                    context,
                                  ) =>
                                      const CouponsDetailsScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TicketWidget(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: double.infinity,
                                height: 124,
                                isCornerRounded: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    1.0,
                                  ),
                                  child: TicketWidget(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    width: double.infinity,
                                    height: 124,
                                    isCornerRounded: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          scale: 8,
                                          'assets/images/cheezious.png',
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Cheezius',
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Gaps.hGap05,
                                            Text(
                                              '70% Off',
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              ),
                                            ),
                                            Gaps.hGap05,
                                            Text(
                                              'Pizza Coupon',
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                            Gaps.hGap10,
                                            Text(
                                              'Valid until: 4/10/2024',
                                              style: TextStyle(
                                                fontFamily: 'Lexend',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
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
