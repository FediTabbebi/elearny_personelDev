import 'package:elearny/model/quiz_model.dart';
import 'package:elearny/provider/quiz_provider/quiz_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:elearny/src/widgets/loading_indicator_widget.dart';
import 'package:elearny/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValidateFields validate = ValidateFields();
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: CustomAppBarWidget(
          title: "Create quiz",
          subtitle: "",
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
              )),
        ),
        body: Form(
          key: context.read<QuizProvider>().formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: TextFormField(
                  controller: context.read<QuizProvider>().quizTitleTextField,
                  decoration: const InputDecoration(hintText: "Quiz title"),
                  validator: (value) => validate.validateEmptyField(value)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: context.read<QuizProvider>().quizUrlTextField,
                decoration: const InputDecoration(
                    hintText: "Put the quiz url here and submit"),
                validator: (value) => validate.validateUrl(value!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  context.watch<QuizProvider>().isLoading
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () async {
                                await context.read<QuizProvider>().submitQuiz(
                                    context,
                                    QuizModel(
                                        quizTitle: context
                                            .read<QuizProvider>()
                                            .quizTitleTextField
                                            .text,
                                        quizLink: context
                                            .read<QuizProvider>()
                                            .quizUrlTextField
                                            .text,
                                        quizId: ''));
                              },
                              child: const Text("Submit"))),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
