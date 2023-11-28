import 'package:elearny/data/globales.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: appBarWidget(
                context, "Quiz", "here you can manage all your quiz")),
      );
    });
  }

  Widget appBarWidget(BuildContext context, String title, String subtitle) {
    return AppBarWidget(
      leftIcon: kIsWeb ? null : Icons.arrow_back,
      onPressedLeftIcon: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.goNamed(AppPage.home.toName);
        }
      },
      rightIcon: null,
      centerTitle: kIsWeb ? true : null,
      title: title,
      rightWidget: deviceType == 1
          ? SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppPage.createQuiz.toName);
                  },
                  child: const Text("Add Quiz")),
            )
          : IconButton(
              onPressed: () {
                context.goNamed(AppPage.createQuiz.toName);
              },
              icon: const Icon(
                FontAwesomeIcons.folderPlus,
              ),
              tooltip: "Add Quiz",
              iconSize: 25,
              splashRadius: 25,
            ),
      subtitle: subtitle,
    );
  }
}
