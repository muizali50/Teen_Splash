import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/add_ticker_notification_screen.dart';
import 'package:teen_splash/model/ticker_notification_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class AllTickerNotification extends StatefulWidget {
  const AllTickerNotification({super.key});

  @override
  State<AllTickerNotification> createState() => _AllTickerNotificationState();
}

class _AllTickerNotificationState extends State<AllTickerNotification> {
  late final AdminBloc adminBloc;
  List<TickerNotificationModel> filterPushNotificationData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.tickerNotifications.isEmpty) {
      adminBloc.add(
        GetTickerNotification(),
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
        _filterPushNotifications();
      },
    );
  }

  void _filterPushNotifications() {
    if (_searchText.isEmpty) {
      filterPushNotificationData = adminBloc.tickerNotifications;
    } else {
      filterPushNotificationData = adminBloc.tickerNotifications
          .where(
            (offer) => offer.title!.toLowerCase().contains(
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
                      'Ticker Notifications',
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
                                const AddTickerNotificationScreen(),
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
                          '+ Add ticker notification',
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
                    if (state is GettingTickerNotification) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetTickerNotificationFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.tickerNotifications.isEmpty
                        ? const Center(
                            child: Text(
                              'No Ticker Notifications',
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
                                  'Title',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Status',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterPushNotificationData.isNotEmpty
                                ? filterPushNotificationData
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.status ?? '',
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
                                                        AddTickerNotificationScreen(
                                                      pushNotification: offer,
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
                                : adminBloc.tickerNotifications
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.status ?? '',
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
                                                        AddTickerNotificationScreen(
                                                      pushNotification: offer,
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
