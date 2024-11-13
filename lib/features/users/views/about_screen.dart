import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/widgets/build_section.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/widgets/build_sub_section.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'About',
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
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildSection(
                          title: "About Teen Splash",
                          content:
                              "Welcome to TeenSplash, the ultimate app for teens to access exclusive discounts, events, and experiences tailored just for them! Designed as a unique membership platform, TeenSplash connects young people with exciting deals, local hotspots, and community events, all while fostering a safe and engaging online space for them to interact."),
                      BuildSection(
                          title: "What TeenSplash Offers",
                          content:
                              'TeenSplash is more than just an app; it’s a gateway to memorable experiences. Registered members can enjoy:'),
                      BuildSubSection(
                          title: "●  Exclusive Discounts",
                          content:
                              "Access unique deals from favorite brands, eateries, clothing stores, and entertainment spots—only available through TeenSplash."),
                      BuildSubSection(
                          title: "●  Local & Regional Connections",
                          content:
                              "Discover businesses in your area and beyond, supporting local vendors while gaining access to exclusive teen-friendly offers."),
                      BuildSubSection(
                          title: "●  Interactive Chatroom",
                          content:
                              "Our app features a chatroom where teens can connect with peers both locally and regionally, sharing recommendations, discussing favorite products, and even promoting services they enjoy. This platform allows for organic word-of-mouth promotion, benefiting vendors while creating a connected teen community."),
                      BuildSubSection(
                          title: "●  EventUpdates",
                          content:
                              "Get real-time notifications for upcoming TeenSplash events, with priority access to ticket sales, special perks, and exclusive insights into what’s happening."),
                      BuildSection(
                          title: "Hydration Reminders",
                          content:
                              'TeenSplash is also committed to promoting health and wellness. Our app includes a hydration reminder feature, popping up three times daily to encourage teens to stay hydrated. These reminders help teens maintain a healthy habit.'),
                      BuildSection(
                          title: "Who We Are – Major Minors Entertainment",
                          content:
                              'TeenSplash is powered by Major Minors Entertainment, a company dedicated to creating safe, exciting, and culturally enriching experiences for young audiences. With a high experience in youth entertainment, we are committed to building a platform that celebrates our vibrant teen community.'),
                      BuildSection(
                          title: "Join the Splash",
                          content:
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
}
