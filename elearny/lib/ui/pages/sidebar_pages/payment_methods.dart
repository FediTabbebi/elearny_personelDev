import 'package:elearny/ui/widgets/shared_widget/app_bar_widget.dart';

import 'package:flutter/material.dart';

class PaymentMedthodScreen extends StatelessWidget {
  const PaymentMedthodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Payment Method',
        subtitle: "Here you can add and edit your lessons",
      ),
    );
  }
}
