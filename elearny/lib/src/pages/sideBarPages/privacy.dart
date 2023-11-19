import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                      'Privacy',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Edit your privacy',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : AppBarUtils.appBarWidget(
                  context, "Privacy", "Edit your privacy")),
    );
  }
}
