import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        'assets/icons/menu.png',
                      ),
                    ),
                  ),
                ),
              ),
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
            'Profile',
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap50,
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
                          Gaps.hGap30,
                          Center(
                            child: Text(
                              '@aryas',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Gaps.hGap40,
                          Container(
                            padding: const EdgeInsets.all(
                              16.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(
                                  0xFFFFD700,
                                ),
                              ),
                              color: const Color(
                                0xFFF8F8F8,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Arya Smith',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xFF999999,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.hGap10,
                                Row(
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Female',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xFF999999,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.hGap10,
                                Row(
                                  children: [
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      '25 y/o',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xFF999999,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.hGap10,
                                Row(
                                  children: [
                                    Text(
                                      'Country',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Barbados 🇧🇧 ',
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xFF999999,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gaps.hGap20,
                          Center(
                            child: Text(
                              'Membership Card',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Gaps.hGap15,
                          Center(
                            child: SizedBox(
                              height: 158,
                              child: Image.asset('assets/images/card.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              // bottom: 670, // Adjust the position as necessary
              // left: 0,
              // right: 0,
              top: 0, // Reduced value from 30 to 15 to pull the card up.
              left: 20,
              right: 20,
              child: Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(
                      0xFFFFD700,
                    ),
                  ),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
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
