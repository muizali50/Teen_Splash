import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/events_photo_gallery.dart';
import 'package:teen_splash/features/users/views/view_more_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Featured Offers',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) =>
                        const ViewMoreScreen(),
                  ),
                );
              },
              child: Text(
                'View More >',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 6.0,
                      ),
                      width: 131,
                      height: 89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1436564989038-18b9958df72b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            color: const Color(0xFFEF589F),
                            child: Text(
                              '20% off',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(
                              5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              size: 10,
                              Icons.favorite,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.hGap05,
                    Text(
                      'ABC Restaurant',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Gaps.hGap05,
        Row(
          children: [
            const Text(
              'Highlighted Sponsors',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFF36F21),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View More >',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFF36F21),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 6.0,
                      ),
                      width: 131,
                      height: 89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap05,
                    Text(
                      'Little Caesars Pizza',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Gaps.hGap05,
        Row(
          children: [
            Text(
              'Event Photo Galleries',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) =>
                        const EventsPhotoGallery(),
                  ),
                );
              },
              child: Text(
                'View More >',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 6.0,
                      ),
                      width: 131,
                      height: 89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap05,
                    Text(
                      'Little Caesars Pizza',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
