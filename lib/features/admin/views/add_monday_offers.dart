import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddMondayOffersScreen extends StatefulWidget {
  final MondayOffersModel? mondayOffer;
  const AddMondayOffersScreen({
    this.mondayOffer,
    super.key,
  });

  @override
  State<AddMondayOffersScreen> createState() => _AddMondayOffersScreenState();
}

class _AddMondayOffersScreenState extends State<AddMondayOffersScreen> {
  late MondayOffersModel mondayOffer;
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _offerNameController = TextEditingController();
  String? coverPhoto;
  String? businessLogo;
  String _selectedDateString = '';
  String discountType = 'Cash Discount';

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

  @override
  void initState() {
    if (widget.mondayOffer != null) {
      _businessNameController.text = widget.mondayOffer!.businessName ?? '';
      _discountController.text = widget.mondayOffer!.discount ?? '';
      discountType = widget.mondayOffer!.discountType ?? '';
      _addressController.text = widget.mondayOffer!.address ?? '';
      _detailsController.text = widget.mondayOffer!.details ?? '';
      _offerNameController.text = widget.mondayOffer!.offerName ?? '';
      _selectedDateString = widget.mondayOffer!.date ?? '';
      coverPhoto = widget.mondayOffer!.image ?? '';
      businessLogo = widget.mondayOffer!.businessLogo ?? '';
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
          widget.mondayOffer != null ? "Edit Offer" : 'Add Offer',
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
                    Container(
                      width: 325,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 0,
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
                            'Discount Type:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            underline: Container(),
                            value: discountType,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Cash Discount',
                                child: Text(
                                  'Cash Discount',
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Percentage Discount',
                                child: Text(
                                  'Percentage Discount',
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  discountType = newValue!;
                                },
                              );
                            },
                          ),
                        ],
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
                        controller: _discountController,
                        hintText: 'Discount',
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
                    if (state is AddMondayOffersSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Offer added successfully',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _addressController.clear();
                      _discountController.clear();
                      _detailsController.clear();
                      _offerNameController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddMondayOffersFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateMondayOffersSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Offer Updated',
                          ),
                        ),
                      );
                      _businessNameController.clear();
                      _addressController.clear();
                      _discountController.clear();
                      _detailsController.clear();
                      _offerNameController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateMondayOffersFailed) {
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
                    if (state is AddingMondayOffers ||
                        state is UpdatingMondayOffers) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.mondayOffer != null ? 'Update' : 'Add',
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
                          if (_discountController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the discount',
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
                          if (widget.mondayOffer != null) {
                            adminBloc.add(
                              UpdateMondayOffers(
                                MondayOffersModel(
                                  offerId: widget.mondayOffer!.offerId,
                                  businessName: _businessNameController.text,
                                  discountType: discountType,
                                  offerName: _offerNameController.text,
                                  address: _addressController.text,
                                  details: _detailsController.text,
                                  discount: _discountController.text,
                                  date: _selectedDateString,
                                  image: coverPhoto,
                                  businessLogo: businessLogo,
                                ),
                                coverPhoto == widget.mondayOffer?.image
                                    ? null
                                    : XFile(coverPhoto!),
                                businessLogo == widget.mondayOffer?.businessLogo
                                    ? null
                                    : XFile(businessLogo!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddMondayOffers(
                                MondayOffersModel(
                                  offerId: DateTime.now().toIso8601String(),
                                  businessName: _businessNameController.text,
                                  discountType: discountType,
                                  offerName: _offerNameController.text,
                                  address: _addressController.text,
                                  discount: _discountController.text,
                                  details: _detailsController.text,
                                  date: _selectedDateString,
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
