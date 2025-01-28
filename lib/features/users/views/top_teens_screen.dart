import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class TopTeensScreen extends StatefulWidget {
  const TopTeensScreen({super.key});

  @override
  State<TopTeensScreen> createState() => _TopTeensScreenState();
}

class _TopTeensScreenState extends State<TopTeensScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Teen Businesses',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This space celebrates and supports the creative ventures of young entrepreneurs, showcasing their talents. This is your go-to hub for discovering youth talent in your communities.',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999),
                        ),
                      ),
                      Gaps.hGap50,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (
                                    //       context,
                                    //     ) =>
                                    //         const OfferDetailsScreen(),
                                    //   ),
                                    // );
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
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1398&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.hGap05,
                                Text(
                                  'ABC Restaurant',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // GridView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: 6,
                      //   gridDelegate:
                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                      //     mainAxisExtent: 120,
                      //     crossAxisCount: 2,
                      //     mainAxisSpacing: 50.0,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     return Center(
                      //       child: Stack(
                      //         clipBehavior: Clip.none,
                      //         children: [
                      //           Container(
                      //             padding: const EdgeInsets.only(
                      //               left: 23,
                      //               right: 23,
                      //               bottom: 20,
                      //               top: 37,
                      //             ),
                      //             decoration: BoxDecoration(
                      //               color:
                      //                   Theme.of(context).colorScheme.surface,
                      //               borderRadius: BorderRadius.circular(
                      //                 12.0,
                      //               ),
                      //               border: Border.all(
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .tertiary,
                      //               ),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black.withOpacity(0.08),
                      //                   offset: const Offset(0, 2),
                      //                   blurRadius: 12,
                      //                 ),
                      //               ],
                      //             ),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 // Gaps.hGap15,
                      //                 Text(
                      //                   '@aryas',
                      //                   style: TextStyle(
                      //                     fontFamily: 'Lexend',
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Theme.of(context)
                      //                         .colorScheme
                      //                         .primary,
                      //                   ),
                      //                 ),
                      //                 Gaps.hGap10,
                      //                 const Text(
                      //                   'Barbados  🇧🇧 ',
                      //                   style: TextStyle(
                      //                     fontFamily: 'OpenSans',
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w400,
                      //                     color: Color(
                      //                       0xFF999999,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: -30,
                      //             left: 0,
                      //             right: 0,
                      //             child: Container(
                      //               height: 63,
                      //               width: 63,
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                   color: const Color(
                      //                     0xFFFFD700,
                      //                   ),
                      //                 ),
                      //                 shape: BoxShape.circle,
                      //                 image: const DecorationImage(
                      //                   fit: BoxFit.cover,
                      //                   image: NetworkImage(
                      //                     'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
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
