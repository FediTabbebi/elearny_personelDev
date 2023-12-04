import 'package:elearny/data/globales.dart';
import 'package:elearny/model/quiz_model.dart';
import 'package:elearny/services/firebase/fireStore/quiz/quiz_service.dart';
import 'package:elearny/src/widgets/loading_progress_dialog.dart';
import 'package:elearny/src/widgets/one_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizProvider with ChangeNotifier {
  String quizId = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  QuizService quizService = QuizService();
  bool isLoading = false;
  bool? isDeleting;
  bool gettingData = true;
  List<QuizModel>? quizModel;

  Future<void> submitQuiz(BuildContext context, QuizModel quizModel) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      await quizService.createQuiz(quizModel).then((value) async {
        //  clearControllers();
        isLoading = false;
        notifyListeners();
        //   showSnackBar("quiz has been added successfully", context);
        showingDialog(context, "Success", "quiz has been added successfully");
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        showSnackBar('$error', context);
      });
    }
  }

  Future<void> deleteQuiz(BuildContext context, String quizId) async {
    BuildContext? context1;
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          context1 = context;
          return const LoadingProgressDialog(
            title: "Please Wait...",
            content: "Deleting quiz ...",
          );
        });

    await quizService
        .deleteQuizDocument(quizId)
        .then((value) => context1!.pop())
        .onError((error, stackTrace) => print("$error"));
  }

//   void initControlers(String? quizTitle,String? quizUrl,String? quizId) {
//    quizTitleTextField.text = quizTitle ?? '';
//   quizUrlTextField.text = quizUrl??'';
//  quizId=quizId?? '' ;
//   }

  // Future<List<QuizModel>?> getAllQuiz(
  //   BuildContext context,
  // ) async {
  //   gettingData = true;

  //   notifyListeners();
  //   await quizService.getAllData().then((value) async {
  //     quizModel = value;

  //     gettingData = false;

  //     notifyListeners();
  //   }).onError((error, stackTrace) {
  //     gettingData = false;

  //     notifyListeners();
  //     showSnackBar('$error', context);
  //     gettingData = false;

  //     notifyListeners();
  //   });
  //   return quizModel;
  // }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
        margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).size.height - 100,
            right: deviceType == 1 ? 10 : 5,
            left: deviceType == 1 ? 260 : 90),
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showingDialog(
    BuildContext context,
    String title,
    String contents,
  ) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return OneButtonDialogWidget(
            title: title,
            contents: contents,
            confirmbuttonText: 'Back',
            onConfirm: () {
              context.pop();
            },
          );
        });
  }

  // Future<void> showingdDeleteDialog(
  //   BuildContext context,
  //   String title,
  //   String contents,
  // ) async {
  //   await
  // }

  // void clearControllers(TextEditingController quizTitleTextField ,TextEditingController quizUrlTextField ) {
  //   quizTitleTextField.clear();
  //   quizUrlTextField.clear();
  // }
}
