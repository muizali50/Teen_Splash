import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/add_events_screen.dart';
import 'package:teen_splash/model/events_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  late final AdminBloc adminBloc;
  List<EventsModel> filterEventData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.events.isEmpty) {
      adminBloc.add(
        GetEvents(),
      );
    }

    searchController.addListener(
      _onSearchChanged,
    );
    super.initState();
  }

  void _onSearchChanged() {
    setState(
      () {
        _searchText = searchController.text;
        _filterEvents();
      },
    );
  }

  void _filterEvents() {
    if (_searchText.isEmpty) {
      filterEventData = adminBloc.events;
    } else {
      filterEventData = adminBloc.events
          .where(
            (coupon) => coupon.name!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 55,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFffffff,
            ),
            borderRadius: BorderRadius.circular(
              05,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Events',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF131313,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (
                              context,
                            ) =>
                                const AddEventsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF000000,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: const Text(
                          '+ Add Event',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xFFffffff,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 277,
                      child: SearchField(
                        controller: searchController,
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingEvents) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetEventsFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.events.isEmpty
                        ? const Center(
                            child: Text(
                              'No Events',
                              style: TextStyle(
                                color: Color(
                                  0xFF131313,
                                ),
                              ),
                            ),
                          )
                        : DataTable(
                            headingTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            dataTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Date',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Time',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterEventData.isNotEmpty
                                ? filterEventData
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.date ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.time ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (
                                                      context,
                                                    ) =>
                                                        AddEventsScreen(
                                                      event: offer,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Edit',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                    0xFF131313,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : adminBloc.events
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.date ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.time ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (
                                                      context,
                                                    ) =>
                                                        AddEventsScreen(
                                                      event: offer,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Edit',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  decoration: TextDecoration
                                                      .underline,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                  color: Color(
                                                    0xFF131313,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
