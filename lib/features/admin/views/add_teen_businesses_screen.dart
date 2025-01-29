import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/teen_business_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddTeenBusinessesScreen extends StatefulWidget {
  final TeenBusinessModel? teenBusiness;
  const AddTeenBusinessesScreen({
    this.teenBusiness,
    super.key,
  });

  @override
  State<AddTeenBusinessesScreen> createState() =>
      _AddTeenBusinessesScreenState();
}

class _AddTeenBusinessesScreenState extends State<AddTeenBusinessesScreen> {
  late TeenBusinessModel teenBusiness;
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _websiteUrlController = TextEditingController();
  String? coverPhoto;
  String? businessLogo;

  @override
  void initState() {
    if (widget.teenBusiness != null) {
      _businessNameController.text = widget.teenBusiness!.businessName ?? '';
      _detailsController.text = widget.teenBusiness!.details ?? '';
      _websiteUrlController.text = widget.teenBusiness!.websiteLink ?? '';
      coverPhoto = widget.teenBusiness!.image ?? '';
      businessLogo = widget.teenBusiness!.businessLogo ?? '';
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
          widget.teenBusiness != null
              ? "Edit Teen Business"
              : 'Add Teen Business',
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
                        controller: _businessNameController,
                        hintText: 'Business Name',
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
                        controller: _websiteUrlController,
                        hintText: 'Link to Business',
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
                Gaps.hGap30,
                const Text(
                  'Upload Business Logo',
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
                                final logoUrl = pickedFile.path;
                                setState(
                                  () {
                                    businessLogo = logoUrl;
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
                    businessLogo != null
                        ? Image.network(businessLogo!, width: 50, height: 50)
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is AddTeenBusinessSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Teen business added successfully',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _detailsController.clear();
                      _websiteUrlController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddTeenBusinessFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateTeenBusinessSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Teen Business Updated',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _websiteUrlController.clear();
                      _detailsController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateTeenBusinessFailed) {
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
                    if (state is AddingTeenBusiness ||
                        state is UpdatingTeenBusiness) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.teenBusiness != null ? 'Update' : 'Add',
                        onTap: () {
                          if (_businessNameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the company/business name',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_websiteUrlController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the link to business',
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

                          if (businessLogo == null || businessLogo!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the logo',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.teenBusiness != null) {
                            adminBloc.add(
                              UpdateTeenBusiness(
                                TeenBusinessModel(
                                  businessId: widget.teenBusiness!.businessId,
                                  businessName: _businessNameController.text,
                                  websiteLink: _websiteUrlController.text,
                                  details: _detailsController.text,
                                  image: coverPhoto,
                                  businessLogo: businessLogo,
                                ),
                                coverPhoto == widget.teenBusiness?.image
                                    ? null
                                    : XFile(coverPhoto!),
                                businessLogo ==
                                        widget.teenBusiness?.businessLogo
                                    ? null
                                    : XFile(businessLogo!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddTeenBusiness(
                                TeenBusinessModel(
                                  businessId: DateTime.now().toIso8601String(),
                                  businessName: _businessNameController.text,                  
                                  websiteLink: _websiteUrlController.text,
                                  details: _detailsController.text,
                                  image: coverPhoto,
                                  businessLogo: businessLogo,
                                ),
                                XFile(coverPhoto!),
                                XFile(businessLogo!),
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
