import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3150), () {
      return context.go("/login");
    });
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/theTeam.png",
            scale: 2.h.w,
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 1500))
              .fadeOut(
                  delay: const Duration(milliseconds: 1750),
                  duration: const Duration(milliseconds: 1000)),
        )
      ],
    ));
  }
}
