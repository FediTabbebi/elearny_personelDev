import 'package:elearny/src/widgets/shared_widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Your account',
        subtitle: 'Edit your account settings and change your password here.',
      ),
    );
  }
}
