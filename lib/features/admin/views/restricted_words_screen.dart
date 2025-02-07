import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/admin/views/add_restriced_words_screen.dart';
import 'package:teen_splash/utils/gaps.dart';

class RestrictedWordsScreen extends StatefulWidget {
  const RestrictedWordsScreen({super.key});

  @override
  State<RestrictedWordsScreen> createState() => _RestrictedWordsScreenState();
}

class _RestrictedWordsScreenState extends State<RestrictedWordsScreen> {
  late final AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetRestrictedWords(),
    );
    super.initState();
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
                      'Restricted Words',
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
                                AddRestrictedWordsScreen(
                              restrictedWords: adminBloc.restricedWords,
                            ),
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
                          '+ Update Restricted Words',
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
                  ],
                ),
                Gaps.hGap30,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingRestrictedWords) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetRestrictedWordsFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.restricedWords == null
                        ? const Center(
                            child: Text(
                              'No Restricted Words',
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
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      'Restricted Words',
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (
                                                  context,
                                                ) =>
                                                    AddRestrictedWordsScreen(
                                                  restrictedWords:
                                                      adminBloc.restricedWords,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
