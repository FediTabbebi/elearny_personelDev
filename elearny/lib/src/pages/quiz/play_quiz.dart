import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayQuizScreen extends StatelessWidget {
  const PlayQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: " Play the Quiz",
            subtitle: "Test your knowledge and improve your skills",
          )),
      body: const Column(children: []),
    );
  }
}
