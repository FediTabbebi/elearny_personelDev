import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewForWeb extends StatefulWidget {
  final String quizUrl;
  const WebViewForWeb({required this.quizUrl, super.key});

  @override
  State<WebViewForWeb> createState() => _WebViewForWebState();
}

class _WebViewForWebState extends State<WebViewForWeb> {
  late final PlatformWebViewController webController;
  @override
  void initState() {
    super.initState();

    webController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(widget.quizUrl),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: webController),
    ).build(context);
  }
}
