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
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: AppBarWidget(
              rightIcon: null,
              leftIcon: kIsWeb ? null : Icons.arrow_back,
              onPressedLeftIcon: () {
                context.pop();
              },
              centerTitle: kIsWeb ? true : null,
              title: " Create Quiz",
              subtitle: null,
            )),
        body: Form(
          key: context.read<QuizProvider>().formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextFormField(
                controller: context.read<QuizProvider>().quizTextField,
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
                          child: LoadingIndicatorWidget(
                              color: Themes.green, size: 40),
                        )
                      : SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () async {
                                await context.read<QuizProvider>().submitQuiz(
                                    context,
                                    QuizModel(
                                        quizLink: context
                                            .read<QuizProvider>()
                                            .quizTextField
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
