import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/settings_screen/widgets/setting_row.dart';
import 'package:teen_splash/features/users/views/submit_survey_answers_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({super.key});

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.surveys.isEmpty) {
      adminBloc.add(
        GetSurvey(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Surveys',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(-4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, state) {
                          if (state is GettingSurvey) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetSurveyFailed) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: adminBloc.surveys.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SettingRow(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (
                                            context,
                                          ) =>
                                              SubmitSurveyAnswerScreen(
                                            survey: adminBloc.surveys[index],
                                          ),
                                        ),
                                      );
                                    },
                                    title: adminBloc.surveys[index].name,
                                    icon: 'assets/icons/forward.png',
                                  ),
                                  Gaps.hGap15,
                                  Divider(
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.1),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
