import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({super.key});

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
                      'Your account',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Edit your account settings and change your password here.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : AppBarUtils.appBarWidget(context, "Your account",
                  "Edit your account settings and change your password here.")),
    );
  }
}
