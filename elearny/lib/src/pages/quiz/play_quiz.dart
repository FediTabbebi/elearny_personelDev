import 'package:elearny/src/widgets/shared_widget/app_bar_widget.dart';
import 'package:elearny/src/widgets/shared_widget/web_view_for_mobile_widget.dart';
import 'package:elearny/src/widgets/shared_widget/web_view_for_web_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayQuizScreen extends StatelessWidget {
  final String quizUrl;
  const PlayQuizScreen({required this.quizUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBarWidget(
            title: " Play the quiz",
            subtitle: "Test your knowledge and improve your skills",
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
          body: kIsWeb
              ? WebViewForWeb(
                  quizUrl: quizUrl,
                )
              : WebViewForMobile(
                  quizUrl: quizUrl,
                )),
    );
  }
}
