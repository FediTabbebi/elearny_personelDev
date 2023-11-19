import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentMedthodScreen extends StatelessWidget {
  const PaymentMedthodScreen({super.key});

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
                      'Payment Method',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'choose or add your payment method',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : appBarWidget(context)),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        Navigator.pop(context);
      },
      rightIcon: null,
      title: 'Payment Method',
      subtitle: 'choose or add your payment method',
    );
  }
}
