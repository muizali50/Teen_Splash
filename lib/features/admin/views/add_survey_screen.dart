import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/survey_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddSurveysScreen extends StatefulWidget {
  final SurveyModel? survey;
  const AddSurveysScreen({
    this.survey,
    super.key,
  });

  @override
  State<AddSurveysScreen> createState() => _AddSurveysScreenState();
}

class _AddSurveysScreenState extends State<AddSurveysScreen> {
  late SurveyModel survey;
  final TextEditingController _nameController = TextEditingController();
  List<TextEditingController> _questionControllers = [];

  void _addQuestion() {
    setState(
      () {
        _questionControllers.add(TextEditingController());
      },
    );
  }

  @override
  void initState() {
    if (widget.survey != null) {
      _nameController.text = widget.survey!.name;
      _questionControllers = widget.survey!.questions
          .map(
            (question) => TextEditingController(text: question),
          )
          .toList();
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
          widget.survey != null ? "Edit Survey" : 'Add Survey',
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
                  ],
                ),
                Gaps.hGap30,
                ..._questionControllers.map(
                  (controller) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        width: 325,
                        child: AppTextField(
                          fillColor: const Color(
                            0xFFEAEAEA,
                          ),
                          controller: controller,
                          hintText: 'Questions',
                        ),
                      ),
                    );
                  },
                ),
                Gaps.hGap15,
                ElevatedButton(
                  onPressed: _addQuestion,
                  child: const Text('Add Question'),
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is AddSurveySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Survey added successfully',
                          ),
                        ),
                      );
                      _nameController.clear();
                      _questionControllers.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is AddSurveyFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateSurveySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Survey notification updated',
                          ),
                        ),
                      );
                      _nameController.clear();
                      _questionControllers.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateSurveyFailed) {
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
                    if (state is AddingSurvey || state is UpdatingSurvey) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.survey != null ? 'Update' : 'Add',
                        onTap: () {
                          // Unfocus all text fields to ensure their text is updated
                          FocusScope.of(context).unfocus();

                          // Validate name
                          if (_nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter the name'),
                              ),
                            );
                            return;
                          }

                          // Validate questions
                          if (_questionControllers.any(
                              (controller) => controller.text.trim().isEmpty)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please ensure all questions are filled in.'),
                              ),
                            );
                            return;
                          }

                          final questions = _questionControllers
                              .map(
                                (c) => c.text.trim(),
                              )
                              .toList();
                          if (widget.survey != null) {
                            adminBloc.add(
                              UpdateSurvey(
                                SurveyModel(
                                  id: widget.survey!.id,
                                  name: _nameController.text,
                                  questions: questions,
                                ),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              AddSurvey(
                                SurveyModel(
                                  id: DateTime.now().toIso8601String(),
                                  name: _nameController.text,
                                  questions: questions,
                                ),
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
