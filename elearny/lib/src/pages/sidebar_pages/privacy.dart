import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Edit your privacy',
        subtitle: 'turn promotional email notifications from elearny on or off',
      ),
    );
  }
}
