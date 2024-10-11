import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
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
                      const AssetImage(
                        'assets/icons/back.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Notifications',
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(
                                12.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF8F8F8,
                                ),
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'New Offers on your way!',
                                    style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Gaps.hGap05,
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'On 03 July 2023',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF767676),
                                      ),
                                    ),
                                  )
                                ],
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
