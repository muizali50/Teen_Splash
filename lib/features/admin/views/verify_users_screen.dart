import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/image_dialog.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class VerifyUsers extends StatefulWidget {
  const VerifyUsers({super.key});

  @override
  State<VerifyUsers> createState() => _VerifyUsersState();
}

class _VerifyUsersState extends State<VerifyUsers> {
  late final AdminBloc adminBloc;
  List<AppUser> filterUserData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.users.isEmpty) {
      adminBloc.add(
        GetUnverifiedUsers(),
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
        _filterUsers();
      },
    );
  }

  void _filterUsers() {
    if (_searchText.isEmpty) {
      filterUserData = adminBloc.users
          .where(
            (user) => user.status == 'Pending',
          )
          .toList();
    } else {
      filterUserData = adminBloc.users
          .where(
            (coupon) => coupon.name.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .where(
            (user) => user.status == 'Pending',
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
                      'Verify Users',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF131313,
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
                    final unverifiedUsers = adminBloc.users
                        .where(
                          (user) => user.status == 'Pending',
                        )
                        .toList();
                    if (state is GettingUnverifiedUsers) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetUnverifiedUsersFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return unverifiedUsers.isEmpty
                        ? const Center(
                            child: Text(
                              'No Unverified User',
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
                                  'Country',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Gender',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterUserData.isNotEmpty
                                ? filterUserData
                                    .map(
                                      (user) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              user.name,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.country ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.gender ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          titleTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          contentTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          title: const Text(
                                                            'Approve Request',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to approve this request?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  ApproveUser(
                                                                    user.uid ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Approve',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Approve',
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
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          titleTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          contentTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          title: const Text(
                                                            'Decline Request',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to decline this request?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  DeclineUser(
                                                                    user.uid ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Decline',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Declined',
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
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Dialog(
                                                        child: ImageDialog(
                                                          imageUrl:
                                                              user.idCardPicture ??
                                                                  '',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'See ID Card',
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
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : unverifiedUsers
                                    .map(
                                      (user) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              user.name,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.country ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.gender ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          titleTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          contentTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          title: const Text(
                                                            'Approve Request',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to approve this request?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  ApproveUser(
                                                                    user.uid ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Approve',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Approve',
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
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          titleTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          contentTextStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                              0xFF131313,
                                                            ),
                                                          ),
                                                          title: const Text(
                                                            'Decline Request',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to decline this request?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  DeclineUser(
                                                                    user.uid ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Decline',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Declined',
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
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Dialog(
                                                        child: ImageDialog(
                                                          imageUrl:
                                                              user.idCardPicture ??
                                                                  '',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'See ID Card',
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
                                              ],
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
