import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/restricted_words.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/admin_button.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class AddRestrictedWordsScreen extends StatefulWidget {
  final RestrictedWordsModel? restrictedWords;
  const AddRestrictedWordsScreen({
    this.restrictedWords,
    super.key,
  });

  @override
  State<AddRestrictedWordsScreen> createState() =>
      _AddRestrictedWordsScreenState();
}

class _AddRestrictedWordsScreenState extends State<AddRestrictedWordsScreen> {
  late RestrictedWordsModel restrictedWords;
  TextEditingController _wordsController = TextEditingController();

  @override
  void initState() {
    if (widget.restrictedWords != null) {
      _wordsController =
          TextEditingController(text: widget.restrictedWords!.words.join(", "));
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
        title: const Text(
          'Add Restricted Words',
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
                SizedBox(
                  width: double.infinity,
                  child: AppTextField(
                    isMaxLine: true,
                    maxLines: 10,
                    fillColor: const Color(
                      0xFFEAEAEA,
                    ),
                    controller: _wordsController,
                    hintText: 'Enter words separated by commas...',
                  ),
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is UpdateRestrictedWordsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Restricted words updated successfully',
                          ),
                        ),
                      );
                      _wordsController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is UpdateRestrictedWordsFailed) {
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
                    if (state is UpdatingRestrictedWords) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: 'Add',
                        onTap: () {
                          final wordsList = _wordsController.text
                              .split(",")
                              .map((e) => e.trim())
                              .toList();
                          if (_wordsController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the description',
                                ),
                              ),
                            );
                            return;
                          }
                          adminBloc.add(
                            UpdateRestrictedWords(
                              wordsList,
                            ),
                          );
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
