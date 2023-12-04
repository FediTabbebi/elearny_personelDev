import 'package:elearny/core/data/globales.dart';
import 'package:elearny/core/models/quiz_model.dart';
import 'package:elearny/core/providers/quiz_provider/quiz_provider.dart';
import 'package:elearny/core/routes/app_routes.dart';
import 'package:elearny/core/services/firestore/quiz/quiz_service.dart';
import 'package:elearny/core/constants/assets.dart';
import 'package:elearny/ui/theme/themes.dart';
import 'package:elearny/ui/widgets/shared_widget/app_bar_widget.dart';
import 'package:elearny/ui/widgets/shared_widget/two_buttons_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});
  final QuizService quizService = QuizService();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: CustomAppBarWidget(
            title: 'Quiz',
            subtitle: "Here you can manage all your quiz",
            actions: [
              deviceType == 1
                  ? UnconstrainedBox(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              context.goNamed(
                                AppPage.createOrUpdateQuiz.toName,
                              );
                            },
                            child: const Text("Add Quiz")),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        context.goNamed(AppPage.createOrUpdateQuiz.toName);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.folderPlus,
                      ),
                      tooltip: "Add Quiz",
                      iconSize: 25,
                      splashRadius: 25,
                    ),
            ],
          ),
          body: StreamProvider<List<QuizModel>?>(
              create: (context) => quizService.getAllData(),
              initialData:
                  null, // Set an initial value while the future is resolving
              child: Consumer<List<QuizModel>?>(
                builder: (context, data, _) {
                  if (data == null) {
                    // Data is still loading or there was an error
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.isEmpty) {
                    // Data is loaded, but the list is empty
                    return const Center(
                      child: Text('No Quiz available.'),
                    );
                  } else {
                    // Data is loaded, and the list is not empty

                    return mainScreen(context, data);
                  }
                },
              )));
    });
  }

  Widget mainScreen(BuildContext context, List<QuizModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 2,
                  shadowColor: Colors.grey,
                  color: Colors.transparent,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(data[index].quizTitle,
                          softWrap: true, overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(data[index].quizUrl,
                          style:
                              const TextStyle(fontSize: 12, color: Themes.grey),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                    ),
                    leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset(Assets.quizImage)),
                    trailing: deviceType == 1
                        ? SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Tooltip(
                                  message: "Preview",
                                  showDuration: const Duration(milliseconds: 0),
                                  child: IconButton(
                                    splashRadius: 15,
                                    icon: const Icon(FontAwesomeIcons.solidEye,
                                        size: 15, color: Color(0xffE3AB0D)),
                                    onPressed: () {
                                      context.goNamed(AppPage.playQuiz.toName,
                                          extra: data[index].quizUrl);
                                    },
                                  ),
                                ),
                                Tooltip(
                                  showDuration: const Duration(milliseconds: 0),
                                  message: "Edit",
                                  child: IconButton(
                                    splashRadius: 15,
                                    icon: const Icon(
                                      FontAwesomeIcons.pen,
                                      color: Themes.green,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      context.goNamed(
                                          AppPage.createOrUpdateQuiz.toName,
                                          extra: data[index]);
                                    },
                                  ),
                                ),
                                Tooltip(
                                  showDuration: const Duration(milliseconds: 0),
                                  message: "Delete",
                                  child: IconButton(
                                    splashRadius: 15,
                                    icon: const Icon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    onPressed: () async {
                                      await showingConfirmDialog(
                                          context,
                                          "Delete Confirmation",
                                          "Are you sure you want to delte this quiz",
                                          () async {
                                        context.pop();
                                        await context
                                            .read<QuizProvider>()
                                            .deleteQuiz(
                                                context, data[index].quizId);
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        : PopupMenuButton<String>(
                            tooltip: "Options",
                            onSelected: (value) {},
                            itemBuilder: (context) => [
                                  PopupMenuItem<String>(
                                    value: 'Preview',
                                    child: const Text('Preview'),
                                    onTap: () {
                                      context.goNamed(AppPage.playQuiz.toName,
                                          extra: data[index].quizUrl);
                                    },
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'Edit',
                                    child: const Text('Edit'),
                                    onTap: () {
                                      context.goNamed(
                                          AppPage.createOrUpdateQuiz.toName,
                                          extra: data[index]);
                                    },
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'Delete',
                                    child: const Text('Delete'),
                                    onTap: () async {
                                      await showingConfirmDialog(
                                          context,
                                          "Delete Confirmation",
                                          "Are you sure you want to delte this quiz",
                                          () async {
                                        context.pop();
                                        await context
                                            .read<QuizProvider>()
                                            .deleteQuiz(
                                                context, data[index].quizId);
                                      });
                                    },
                                  ),
                                ],
                            child: const Icon(
                              FontAwesomeIcons.ellipsisVertical,
                              color: Themes.grey,
                              size: 20,
                            )),
                  ),
                ))
            // .animate()
            // .scaleY(
            //     duration: const Duration(milliseconds: 350),
            //     curve: Curves.easeInOut,
            //     delay: Duration(milliseconds: index * 120))
            ;
      },
    );
  }

  Future<void> showingConfirmDialog(
    BuildContext context,
    String title,
    String contents,
    VoidCallback onConfirm,
  ) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return TwoButtonsDialogWidget(
            title: title,
            contents: contents,
            confirmbuttonText: 'Confirm',
            onConfirm: () async {
              onConfirm();
            },
            declinebuttonText: 'Back',
            onDecline: () {
              context.pop();
            },
          );
        });
  }
}
