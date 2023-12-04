import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewForMobile extends StatefulWidget {
  final String quizUrl;
  const WebViewForMobile({required this.quizUrl, super.key});

  @override
  State<WebViewForMobile> createState() => _WebViewForMobileState();
}

class _WebViewForMobileState extends State<WebViewForMobile> {
  late final WebViewController mobileController;
  double loadingProgress = 0;
  @override
  void initState() {
    super.initState();

    mobileController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            setState(() {
              loadingProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.quizUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loadingProgress < 1
            ? SizedBox(
                height: 5,
                child: LinearProgressIndicator(
                  value: loadingProgress,
                  color: Themes.green,
                  backgroundColor: context.read<ThemeProvider>().isDarkMode
                      ? Themes.darkMode
                      : Themes.greyWhite,
                ),
              )
            : Expanded(
                child: WebViewWidget(controller: mobileController),
              )
      ],
    );
  }
}
