import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/sponsors_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddHighlightedSponsorScreen extends StatefulWidget {
  final SponsorsModel? sponsor;
  const AddHighlightedSponsorScreen({
    this.sponsor,
    super.key,
  });

  @override
  State<AddHighlightedSponsorScreen> createState() =>
      _AddHighlightedSponsorScreenState();
}

class _AddHighlightedSponsorScreenState
    extends State<AddHighlightedSponsorScreen> {
  late SponsorsModel sponsor;
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _offerNameController = TextEditingController();
  final TextEditingController _websiteLinkController = TextEditingController();
  String? coverPhoto;
  String? businessLogo;

  @override
  void initState() {
    if (widget.sponsor != null) {
      _businessNameController.text = widget.sponsor!.businessName ?? '';
      _addressController.text = widget.sponsor!.address ?? '';
      _detailsController.text = widget.sponsor!.details ?? '';
      _offerNameController.text = widget.sponsor!.offerName ?? '';
      coverPhoto = widget.sponsor!.image ?? '';
      businessLogo = widget.sponsor!.businessLogo ?? '';
      _websiteLinkController.text = widget.sponsor!.websiteLink ?? '';
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
          widget.sponsor != null ? "Edit Offer" : 'Add Offer',
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
                        hintText: 'Company/Business Name',
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
                        controller: _offerNameController,
                        hintText: 'Offer Name',
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
                        controller: _addressController,
                        hintText: 'Address',
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                Row(
                  children: [
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
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 325,
                      child: AppTextField(
                        fillColor: const Color(
                          0xFFEAEAEA,
                        ),
                        controller: _websiteLinkController,
                        hintText: 'Website Link',
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
                    if (state is AddSponsorSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Offer added successfully',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _addressController.clear();
                      _detailsController.clear();
                      _offerNameController.clear();
                      _websiteLinkController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddSponsorFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateSponsorSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Offer Updated',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _addressController.clear();
                      _detailsController.clear();
                      _offerNameController.clear();
                      _websiteLinkController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateSponsorFailed) {
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
                    if (state is AddingSponsor || state is UpdatingSponsor) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.sponsor != null ? 'Update' : 'Add',
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
                          if (_offerNameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the offer name',
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
                          if (_addressController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the address',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_websiteLinkController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the website link',
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
                          if (widget.sponsor != null) {
                            adminBloc.add(
                              UpdateSponsors(
                                SponsorsModel(
                                  sponsorId: widget.sponsor!.sponsorId,
                                  businessName: _businessNameController.text,
                                  offerName: _offerNameController.text,
                                  address: _addressController.text,
                                  websiteLink: _websiteLinkController.text,
                                  details: _detailsController.text,
                                  image: coverPhoto,
                                  businessLogo: businessLogo,
                                ),
                                coverPhoto == widget.sponsor?.image
                                    ? null
                                    : XFile(coverPhoto!),
                                businessLogo == widget.sponsor?.businessLogo
                                    ? null
                                    : XFile(businessLogo!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddSponsors(
                                SponsorsModel(
                                  sponsorId: DateTime.now().toIso8601String(),
                                  businessName: _businessNameController.text,
                                  offerName: _offerNameController.text,
                                  address: _addressController.text,
                                  websiteLink: _websiteLinkController.text,
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
