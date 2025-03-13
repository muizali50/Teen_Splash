import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class NotificationsScreen extends StatefulWidget {
  final bool isGuest;
  const NotificationsScreen({
    required this.isGuest,
    super.key,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    // if (adminBloc.pushNotifications.isEmpty) {
    //   adminBloc.add(
    //     GetPushNotification(),
    //   );
    // }
    adminBloc.add(
      GetPushNotification(),
    );
    super.initState();
  }

  Future<void> _refreshNotifications() async {
    adminBloc.add(
      GetPushNotification(),
    ); // Fetch latest notifications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isTittle: true,
          title: 'Notifications',
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
                child: widget.isGuest
                    ? Center(
                        child: Text('This screen is restricted for guests'),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshNotifications,
                        child: BlocBuilder<AdminBloc, AdminState>(
                          builder: (context, state) {
                            final filteredNotification =
                                adminBloc.pushNotifications.where(
                              (noti) {
                                return noti.userIds!.contains(
                                    FirebaseAuth.instance.currentUser!.uid);
                              },
                            ).toList()
                                  ..sort(
                                    (a, b) => DateTime.parse(b.date!).compareTo(
                                      DateTime.parse(a.date!),
                                    ),
                                  );

                            if (state is GettingPushNotification) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetPushNotificationFailed) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            return filteredNotification.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No Notifications',
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: filteredNotification.length,
                                    itemBuilder: (context, index) {
                                      String isoDate =
                                          filteredNotification[index]
                                              .date
                                              .toString();
                                      DateTime parsedDate =
                                          DateTime.parse(isoDate);
                                      String formattedDate =
                                          DateFormat('d MMMM yyyy')
                                              .format(parsedDate);
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filteredNotification[index]
                                                        .title ??
                                                    '',
                                                style: const TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                              Gaps.hGap05,
                                              Text(
                                                filteredNotification[index]
                                                        .content ??
                                                    '',
                                                style: const TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF767676),
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'On $formattedDate',
                                                  style: const TextStyle(
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
                                  );
                          },
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
