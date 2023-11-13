import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class AppBarUtils {
  static Widget appBarWidget(
      BuildContext context, String title, String subtitle) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        Navigator.pop(context);
      },
      rightIcon: null,
      title: title,
      subtitle: subtitle,
    );
  }
}
