import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/events_detail_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class UpcommingEvents extends StatefulWidget {
  const UpcommingEvents({super.key});

  @override
  State<UpcommingEvents> createState() => _UpcommingEventsState();
}

class _UpcommingEventsState extends State<UpcommingEvents> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.events.isEmpty) {
      adminBloc.add(
        GetEvents(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              final now = DateTime.now();
              final timeFormatter = DateFormat('hh:mm a');
              final upcomingEvents = adminBloc.events.where(
                (event) {
                  if (event.date == null || event.time == null) return false;
                  try {
                    final eventDate = DateTime.tryParse(event.date!);
                    if (eventDate == null) return false;

                    final eventTime = timeFormatter.parse(event.time!);

                    final eventDateTime = DateTime(
                      eventDate.year,
                      eventDate.month,
                      eventDate.day,
                      eventTime.hour,
                      eventTime.minute,
                    );

                    return eventDateTime.isAfter(now);
                  } catch (e) {
                    return false;
                  }
                },
              ).toList();
              if (state is GettingEvents) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetEventsFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              return upcomingEvents.isEmpty
                  ? const Center(
                      child: Text('No Upcomming Events'),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: upcomingEvents.length,
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
                                      EventsDetailScreen(
                                        event: upcomingEvents[index],
                                      ),
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
                                    image:  DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        upcomingEvents[index].image ?? '',
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.hGap10,
                                Text(
                                  upcomingEvents[index].name ?? '',
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
                                    Text(
                                      upcomingEvents[index].location ?? '',
                                      style: const TextStyle(
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
                    );
            },
          ),
        ],
      ),
    );
  }
}
