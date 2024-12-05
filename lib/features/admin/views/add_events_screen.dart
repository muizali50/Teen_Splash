import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/events_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddEventsScreen extends StatefulWidget {
  final EventsModel? event;
  const AddEventsScreen({
    this.event,
    super.key,
  });

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  late EventsModel event;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String? coverPhoto;
  String _selectedDateString = '';
  String _selectedTimeString = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(
        () {
          _selectedDateString =
              '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
        },
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(
        () {
          final hour =
              pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
          final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
          _selectedTimeString =
              '${hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} $period';
        },
      );
    }
  }

  @override
  void initState() {
    if (widget.event != null) {
      _nameController.text = widget.event!.name ?? '';
      _locationController.text = widget.event!.location ?? '';
      _detailsController.text = widget.event!.details ?? '';
      coverPhoto = widget.event!.image ?? '';
      _selectedDateString = widget.event!.date ?? '';
      _selectedTimeString = widget.event!.time ?? '';
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
          widget.event != null ? "Edit Event" : 'Add Event',
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
                        controller: _nameController,
                        hintText: 'Name',
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
                        controller: _locationController,
                        hintText: 'Address',
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
                        controller: _detailsController,
                        hintText: 'Details',
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                Row(
                  children: [
                    Container(
                      width: 325,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
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
                            'Date:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _selectedDateString,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectDate(context),
                            icon: const Icon(
                              size: 20,
                              color: Color(0xff000000),
                              Icons.calendar_month_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 325,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
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
                            'Time:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _selectedTimeString,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectTime(context),
                            icon: const Icon(
                              size: 20,
                              color: Color(0xff000000),
                              CupertinoIcons.clock,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFF000000,
                    ),
                  ),
                ),
                Gaps.hGap15,
                Row(
                  children: [
                    DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 2,
                      color: const Color(
                        0xFF000000,
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              final pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );

                              if (pickedFile != null) {
                                final coverPhotoUrl = pickedFile.path;
                                setState(
                                  () {
                                    coverPhoto = coverPhotoUrl;
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  0xFF000000,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  color: Color(
                                    0xFFffffff,
                                  ),
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    coverPhoto != null
                        ? Image.network(coverPhoto!, width: 50, height: 50)
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is AddEventsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Event added successfully',
                          ),
                        ),
                      );
                      _nameController.clear();
                      _locationController.clear();
                      _detailsController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddEventsFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateEventsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Event Updated',
                          ),
                        ),
                      );
                      _nameController.clear();
                      _locationController.clear();
                      _detailsController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateEventsFailed) {
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
                    if (state is AddingEvents || state is UpdatingEvents) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.event != null ? 'Update' : 'Add',
                        onTap: () {
                          if (_nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the name',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_locationController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the address',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_detailsController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the details',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_selectedDateString.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the date',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_selectedTimeString.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the time',
                                ),
                              ),
                            );
                            return;
                          }
                          if (coverPhoto == null || coverPhoto!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the image',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.event != null) {
                            adminBloc.add(
                              UpdateEvents(
                                EventsModel(
                                  eventId: widget.event!.eventId,
                                  name: _nameController.text,
                                  location: _locationController.text,
                                  details: _detailsController.text,
                                  date: _selectedDateString,
                                  time: _selectedTimeString,
                                  image: coverPhoto,
                                ),
                                coverPhoto == widget.event?.image
                                    ? null
                                    : XFile(coverPhoto!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddEvents(
                                EventsModel(
                                  eventId: DateTime.now().toIso8601String(),
                                  name: _nameController.text,
                                  location: _locationController.text,
                                  details: _detailsController.text,
                                  date: _selectedDateString,
                                  time: _selectedTimeString,
                                  image: coverPhoto,
                                ),
                                XFile(coverPhoto!),
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
