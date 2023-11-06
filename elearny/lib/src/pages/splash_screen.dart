import 'package:elearny/model/user.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationServices>(context, listen: false);
    return StreamBuilder<UserModel?>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserModel? user = snapshot.data;
          if (user == null) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
          Navigator.pushReplacementNamed(context, Routes.home);
          //return Navigator.pushReplacementNamed(context, Routes.login);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
