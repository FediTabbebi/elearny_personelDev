import 'package:elearny/ui/widgets/shared_widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

class SubScriptionsScreen extends StatelessWidget {
  const SubScriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Subscriptions',
        subtitle: 'Manage elearny subscriptions',
      ),
    );
  }
}
