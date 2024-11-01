import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/add_highlighted_sponsors_screen.dart';
import 'package:teen_splash/model/sponsors_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class AllHighlightedSponsor extends StatefulWidget {
  const AllHighlightedSponsor({super.key});

  @override
  State<AllHighlightedSponsor> createState() => _AllHighlightedSponsorState();
}

class _AllHighlightedSponsorState extends State<AllHighlightedSponsor> {
  late final AdminBloc adminBloc;
  List<SponsorsModel> filterSponsorData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.sponsors.isEmpty) {
      adminBloc.add(
        GetSponsors(),
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
      filterSponsorData = adminBloc.sponsors;
    } else {
      filterSponsorData = adminBloc.sponsors
          .where(
            (offer) => offer.businessName!.toLowerCase().contains(
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
                      'Highlighted Sponsors',
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
                                const AddHighlightedSponsorScreen(),
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
                          '+ Add highlighted sponsor',
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
                    if (state is GettingSponsor) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetSponsorFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.sponsors.isEmpty
                        ? const Center(
                            child: Text(
                              'No Sponsors',
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
                                  'Offer Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterSponsorData.isNotEmpty
                                ? filterSponsorData
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.businessName ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.offerName ?? '',
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
                                                        AddHighlightedSponsorScreen(
                                                      sponsor: offer,
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
                                : adminBloc.sponsors
                                    .map(
                                      (offer) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              offer.businessName ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              offer.offerName ?? '',
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
                                                        AddHighlightedSponsorScreen(
                                                      sponsor: offer,
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
