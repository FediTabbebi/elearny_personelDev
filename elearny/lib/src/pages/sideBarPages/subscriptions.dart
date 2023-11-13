import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubScriptionsScreen extends StatelessWidget {
  const SubScriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: kIsWeb
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Subscriptions',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Manage your elearny subscriptions',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : AppBarUtils.appBarWidget(context, "Subscriptions",
                  "Manage your elearny subscriptions")),
    );
  }
}
