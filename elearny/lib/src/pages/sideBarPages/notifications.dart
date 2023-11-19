import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: kIsWeb
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notification',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'turn promotional email notifications from elearny on or off',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : AppBarUtils.appBarWidget(context, "Notification",
                  "turn promotional email notifications from elearny on or off")),
    );
  }
}
