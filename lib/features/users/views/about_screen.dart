import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
            'About',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection("About Teen Splash",
                          "Welcome to TeenSplash, the ultimate app for teens to access exclusive discounts, events, and experiences tailored just for them! Designed as a unique membership platform, TeenSplash connects young people with exciting deals, local hotspots, and community events, all while fostering a safe and engaging online space for them to interact."),
                      _buildSection("What TeenSplash Offers",
                          'TeenSplash is more than just an app; it’s a gateway to memorable experiences. Registered members can enjoy:'),
                      _buildSubSection("●  Exclusive Discounts",
                          "Access unique deals from favorite brands, eateries, clothing stores, and entertainment spots—only available through TeenSplash."),
                      _buildSubSection("●  Local & Regional Connections",
                          "Discover businesses in your area and beyond, supporting local vendors while gaining access to exclusive teen-friendly offers."),
                      _buildSubSection("●  Interactive Chatroom",
                          "Our app features a chatroom where teens can connect with peers both locally and regionally, sharing recommendations, discussing favorite products, and even promoting services they enjoy. This platform allows for organic word-of-mouth promotion, benefiting vendors while creating a connected teen community."),
                      _buildSubSection("●  EventUpdates",
                          "Get real-time notifications for upcoming TeenSplash events, with priority access to ticket sales, special perks, and exclusive insights into what’s happening."),
                      _buildSection("Hydration Reminders",
                          'TeenSplash is also committed to promoting health and wellness. Our app includes a hydration reminder feature, popping up three times daily to encourage teens to stay hydrated. These reminders help teens maintain a healthy habit.'),
                      _buildSection("Who We Are – Major Minors Entertainment",
                          'TeenSplash is powered by Major Minors Entertainment, a company dedicated to creating safe, exciting, and culturally enriching experiences for young audiences. With a high experience in youth entertainment, we are committed to building a platform that celebrates our vibrant teen community.'),
                      _buildSection("Join the Splash",
                          'Whether you’re a TeenSplash regular or new to the scene, the app is designed to make every outing more rewarding. Download TeenSplash, unlock exclusive offers, and dive into a world of discounts, events, and connections crafted just for teens. Welcome to a community where fun and savings meet!'),
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

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
