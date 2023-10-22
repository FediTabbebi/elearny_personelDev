import 'package:elearny/data/globales.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Welcome" "${currentUser!.firstName}")),
          Center(child: Text("Welcome" "${currentUser!.email}"))
        ],
      ),
    );
  }
}
