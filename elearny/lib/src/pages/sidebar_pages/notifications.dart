import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Notification',
        subtitle: 'turn promotional email notifications from elearny on or off',
      ),
    );
  }
}
