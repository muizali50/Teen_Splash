import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/services/push_notification_service.dart';

class SurveyAnswersScreen extends StatefulWidget {
  final String surveyId;

  const SurveyAnswersScreen({
    super.key,
    required this.surveyId,
  });

  @override
  State<SurveyAnswersScreen> createState() => _SurveyAnswersScreenState();
}

class _SurveyAnswersScreenState extends State<SurveyAnswersScreen> {
  final pushNotificationService = PushNotificationService();
  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Survey Answers',
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
          child: BlocProvider(
            create: (_) => AdminBloc()
              ..add(
                GetSurveyAnswers(
                  widget.surveyId,
                ),
              ),
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is GettingSurveyAnswers) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetSurveyAnswersFailed) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                    ),
                  );
                } else if (state is GetSurveyAnswersSuccess) {
                  final answers = state.answers;
                  if (answers.isEmpty) {
                    return const Center(
                      child: Text(
                        'No answers found.',
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      final answer = answers[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User: ${answer.userName} (${answer.userEmail})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              ...answer.answers.entries.map<Widget>(
                                (entry) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      '${entry.key}: ${entry.value}',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No data available.'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
