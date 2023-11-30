import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:go_router/go_router.dart';

class PlayQuizScreen extends StatelessWidget {
  const PlayQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
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
        body: Center(
          child: HtmlWidget(
            '<iframe src="https://www.flexiquiz.com/SC/N/a81ba8ed-34e1-40fc-82ae-073258e41d44"></iframe>',
            factoryBuilder: () => MyWidgetFactory(),
          ),
        ),
      );
    });
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  // optional: override getter to configure how WebViews are built
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  String? get webViewUserAgent => 'My app';
}
