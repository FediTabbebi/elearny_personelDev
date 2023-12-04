import 'package:elearny/model/quiz_model.dart';
import 'package:elearny/provider/quiz_provider/quiz_provider.dart';
import 'package:elearny/src/widgets/shared_widget/app_bar_widget.dart';
import 'package:elearny/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateOrUpdateQuizScreen extends StatelessWidget {
  final QuizModel? quizModel;
  const CreateOrUpdateQuizScreen({this.quizModel, super.key});

  @override
  Widget build(BuildContext context) {
    final ValidateFields validate = ValidateFields();
    final TextEditingController quizTitleTextField =
        TextEditingController(text: quizModel?.quizTitle ?? '');
    final TextEditingController quizUrlTextField =
        TextEditingController(text: quizModel?.quizUrl ?? '');
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
                    controller: quizTitleTextField,
                    onFieldSubmitted: (value) {},
                    onSaved: (newValue) {},
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
                  controller: quizUrlTextField,
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
                                  await context
                                      .read<QuizProvider>()
                                      .submitQuiz(
                                          context,
                                          QuizModel(
                                              quizTitle:
                                                  quizTitleTextField.text,
                                              quizUrl: quizUrlTextField.text,
                                              quizId: quizModel?.quizId ?? ''))
                                      .then((value) {});
                                },
                                child: const Text("Submit"))),
                  ],
                ),
              )
            ]),
          ));
    });
  }
}
