import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddPushNotificationScreen extends StatefulWidget {
  final PushNotificationModel? pushNotification;
  const AddPushNotificationScreen({
    this.pushNotification,
    super.key,
  });

  @override
  State<AddPushNotificationScreen> createState() =>
      _AddPushNotificationScreenState();
}

class _AddPushNotificationScreenState extends State<AddPushNotificationScreen> {
  late final UserBloc userBloc;
  late PushNotificationModel pushNotification;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<String> _userIds = [];

  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    if (userBloc.users.isEmpty) {
      userBloc.add(
        GetAllUsers(),
      );
    }

    if (widget.pushNotification != null) {
      _titleController.text = widget.pushNotification!.title ?? '';
      _contentController.text = widget.pushNotification!.content ?? '';
      _userIds = List.from(widget.pushNotification!.userIds!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.watch<AdminBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
      ),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(
            0xFF000000,
          ),
        ),
        title: Text(
          widget.pushNotification != null
              ? "Edit Push Notification"
              : 'Add Push Notification',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            color: Color(0xFF000000),
            CupertinoIcons.back,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 15,
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
                    SizedBox(
                      width: 325,
                      child: AppTextField(
                        fillColor: const Color(
                          0xFFEAEAEA,
                        ),
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 325,
                      child: AppTextField(
                        fillColor: const Color(
                          0xFFEAEAEA,
                        ),
                        controller: _contentController,
                        hintText: 'Content',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 325,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        // vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEAEAEA,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Select Users',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    height: 200,
                                    width: 300,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      color: const Color(
                                        0xFFffffff,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Select Users',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xFF131313,
                                            ),
                                          ),
                                        ),
                                        Gaps.hGap15,
                                        StatefulBuilder(
                                          builder: (context, localState) {
                                            return BlocBuilder<UserBloc,
                                                UserState>(
                                              builder: (context, state) {
                                                final filteredusers =
                                                    userBloc.users;
                                                if (state is GettingAllUsers) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (state
                                                    is GetAllUsersFailed) {
                                                  return Center(
                                                    child: Text(state.message),
                                                  );
                                                }
                                                return Expanded(
                                                  child: ListView.builder(
                                                    itemCount:
                                                        filteredusers.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        children: [
                                                          Text(
                                                            filteredusers[index]
                                                                .name
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                0xFF131313,
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            onPressed: () {
                                                              localState(
                                                                () {
                                                                  if (_userIds
                                                                          .contains(
                                                                        filteredusers[index]
                                                                            .uid
                                                                            .toString(),
                                                                      ) ==
                                                                      true) {
                                                                    _userIds
                                                                        .remove(
                                                                      filteredusers[
                                                                              index]
                                                                          .uid
                                                                          .toString(),
                                                                    );
                                                                  } else {
                                                                    _userIds
                                                                        .add(
                                                                      filteredusers[
                                                                              index]
                                                                          .uid
                                                                          .toString(),
                                                                    );
                                                                  }
                                                                },
                                                              );
                                                            },
                                                            icon: Icon(
                                                              color: const Color(
                                                                  0xFF131313),
                                                              _userIds.contains(
                                                                        filteredusers[index]
                                                                            .uid
                                                                            .toString(),
                                                                      ) ==
                                                                      true
                                                                  ? Icons
                                                                      .check_box
                                                                  : Icons
                                                                      .check_box_outline_blank,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              color: Color(0xFF131313),
                              Icons.arrow_drop_down_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is AddPushNotificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Push notification added successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddPushNotificationFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdatePushNotificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Push notification updated',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdatePushNotificationFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddingPushNotification ||
                        state is UpdatingPushNotification) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text:
                            widget.pushNotification != null ? 'Update' : 'Add',
                        onTap: () {
                          if (_titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the title',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_contentController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the content',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_userIds.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the user',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.pushNotification != null) {
                            adminBloc.add(
                              UpdatePushNotification(
                                PushNotificationModel(
                                  pushNotificationId: widget
                                      .pushNotification!.pushNotificationId,
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  userIds: _userIds,
                                ),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddPushNotification(
                                PushNotificationModel(
                                  pushNotificationId:
                                      DateTime.now().toIso8601String(),
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  userIds: _userIds,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
