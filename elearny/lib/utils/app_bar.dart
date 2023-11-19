import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarUtils {
  static Widget appBarWidget(
      BuildContext context, String title, String subtitle) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go("/");
        }
      },
      rightIcon: null,
      title: title,
      subtitle: subtitle,
    );
  }
}
