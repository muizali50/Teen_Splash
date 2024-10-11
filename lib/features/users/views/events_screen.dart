import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/events_detail_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
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
                          'assets/icons/menu.png',
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ),
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
                        const AssetImage(
                          'assets/icons/chat.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            'Events',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap20,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        const EventsDetailScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 148,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://images.unsplash.com/photo-1522158637959-30385a09e0da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gaps.hGap10,
                                  Text(
                                    'Teen Splash Brek Fete',
                                    style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Gaps.hGap05,
                                  Row(
                                    children: [
                                      ImageIcon(
                                        size: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        const AssetImage(
                                          'assets/icons/location.png',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      const Text(
                                        'Cricket Legends (Barbados)',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ],
                                  ),
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
