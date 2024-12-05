import 'package:flutter/material.dart';
import 'package:teen_splash/model/events_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EventsDetailScreen extends StatefulWidget {
  final EventsModel event;
  const EventsDetailScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {
  Future<void> _launchWebsite(String? url, BuildContext context) async {
    if (url != null && await launchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch the link.',
          ),
        ),
      );
    }
  }

  String getDayOfWeek(String date) {
    try {
      final eventDate = DateTime.parse(date); // Parse the date string
      const daysOfWeek = [
        'Monday', // 1
        'Tuesday', // 2
        'Wednesday', // 3
        'Thursday', // 4
        'Friday', // 5
        'Saturday', // 6
        'Sunday' // 7
      ];
      return daysOfWeek[eventDate.weekday - 1]; // Map to day name
    } catch (e) {
      return ''; // Return empty if date parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = getDayOfWeek(widget.event.date!);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 227,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.event.image.toString(),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 65,
                      left: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
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
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          32.0,
                        ),
                        topRight: Radius.circular(
                          32.0,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$dayOfWeek, ${widget.event.date}, ${widget.event.time}',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Gaps.hGap15,
                      Text(
                        widget.event.name.toString(),
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap15,
                      Row(
                        children: [
                          ImageIcon(
                            color: Theme.of(context).colorScheme.tertiary,
                            const AssetImage(
                              'assets/icons/location.png',
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            widget.event.location.toString(),
                            style: const TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap20,
                      Text(
                        'Details',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap15,
                      Text(
                        widget.event.details.toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      AppPrimaryButton(
                        text: 'Link to Event',
                        onTap: () => _launchWebsite(
                          widget.event.websiteUrl.toString(),
                          context,
                        ),
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
