import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/model/survey_answer_model.dart';
import 'package:teen_splash/model/survey_model.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class SubmitSurveyAnswerScreen extends StatefulWidget {
  final SurveyModel survey;
  const SubmitSurveyAnswerScreen({
    super.key,
    required this.survey,
  });

  @override
  State<SubmitSurveyAnswerScreen> createState() =>
      _SubmitSurveyAnswerScreenState();
}

class _SubmitSurveyAnswerScreenState extends State<SubmitSurveyAnswerScreen> {
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    authenticationBloc.add(
      const GetUser(),
    );
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final adminBloc = context.read<AdminBloc>();
    final controllers =
        widget.survey.questions.map((_) => TextEditingController()).toList();

    void submitAnswers() {
      final answers = {
        for (int i = 0; i < widget.survey.questions.length; i++)
          widget.survey.questions[i]: controllers[i].text,
      };
      final answer = SurveyAnswerModel(
        userId: userProvider.user?.uid ?? '',
        userName: userProvider.user?.name ?? '',
        userEmail: userProvider.user?.email ?? '',
        answers: answers,
      );
      adminBloc.add(
        SubmitSurveyAnswer(widget.survey.id, answer),
      );
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Submit Answers',
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
                child: ListView(
                  children: [
                    ...widget.survey.questions.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final question = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: controllers[index],
                            ),
                            Gaps.hGap15,
                          ],
                        );
                      },
                    ),
                    Gaps.hGap20,
                    BlocConsumer<AdminBloc, AdminState>(
                      listener: (context, state) {
                        if (state is SubmittingSurveyAnswerSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Submitted Successfully',
                              ),
                            ),
                          );
                        } else if (state is SubmittingSurveyAnswerFailed) {
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
                        if (state is SubmittingSurveyAnswer) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return AppPrimaryButton(
                          text: 'Submit',
                          onTap: () {
                            submitAnswers();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
