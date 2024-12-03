import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/ticker_notification_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddTickerNotificationScreen extends StatefulWidget {
  final TickerNotificationModel? pushNotification;
  const AddTickerNotificationScreen({
    this.pushNotification,
    super.key,
  });

  @override
  State<AddTickerNotificationScreen> createState() =>
      _AddTickerNotificationScreenState();
}

class _AddTickerNotificationScreenState
    extends State<AddTickerNotificationScreen> {
  late TickerNotificationModel pushNotification;
  final TextEditingController _titleController = TextEditingController();
  String status = 'Inactive';

  @override
  void initState() {
    if (widget.pushNotification != null) {
      _titleController.text = widget.pushNotification!.title ?? '';
      status = widget.pushNotification!.status ?? '';
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
              ? "Edit Ticker Notification"
              : 'Add Ticker Notification',
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
                            'Status:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            style: const TextStyle(
                              color: Color(0xFF000000),
                            ),
                            underline: Container(),
                            value: status,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Active',
                                child: Text(
                                  'Active',
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Inactive',
                                child: Text(
                                  'Inactive',
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  status = newValue!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is AddTickerNotificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ticker notification added successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddTickerNotificationFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateTickerNotificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ticker notification updated',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateTickerNotificationFailed) {
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
                    if (state is AddingTickerNotification ||
                        state is UpdatingTickerNotification) {
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

                          if (widget.pushNotification != null) {
                            adminBloc.add(
                              UpdateTickerNotification(
                                TickerNotificationModel(
                                  pushNotificationId: widget
                                      .pushNotification!.pushNotificationId,
                                  title: _titleController.text,
                                  status: status,
                                ),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddTickerNotification(
                                TickerNotificationModel(
                                  pushNotificationId:
                                      DateTime.now().toIso8601String(),
                                  title: _titleController.text,
                                  status: status,
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
