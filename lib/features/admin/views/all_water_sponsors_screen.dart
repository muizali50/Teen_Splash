import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/add_water_sponsor_screen.dart';
import 'package:teen_splash/model/water_sponsor_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class AllWaterSponsor extends StatefulWidget {
  const AllWaterSponsor({super.key});

  @override
  State<AllWaterSponsor> createState() => _AllWaterSponsorState();
}

class _AllWaterSponsorState extends State<AllWaterSponsor> {
  late final AdminBloc adminBloc;
  List<WaterSponsorModel> filterWaterSponsorData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.waterSponsors.isEmpty) {
      adminBloc.add(
        GetWaterSponsor(),
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
        _filterSponsors();
      },
    );
  }

  void _filterSponsors() {
    if (_searchText.isEmpty) {
      filterWaterSponsorData = adminBloc.waterSponsors;
    } else {
      filterWaterSponsorData = adminBloc.waterSponsors
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
                      'Water Sponsors',
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
                                  const AddWaterSponsorScreen()),
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
                          '+ Add water sponsor',
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
                    if (state is GettingWaterSponsor) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetWaterSponsorFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.waterSponsors.isEmpty
                        ? const Center(
                            child: Text(
                              'No Water Sponsors',
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
                            rows: filterWaterSponsorData.isNotEmpty
                                ? filterWaterSponsorData
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
                                                        AddWaterSponsorScreen(
                                                      waterSponsor: offer,
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
                                : adminBloc.waterSponsors
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
                                                        AddWaterSponsorScreen(
                                                      waterSponsor: offer,
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
