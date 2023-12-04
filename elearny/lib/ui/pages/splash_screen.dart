import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/providers/app_service/app_service.dart';
import 'package:elearny/core/constants/assets.dart';
import 'package:elearny/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppService appService = locator<AppService>();

  @override
  void initState() {
    onStartUp();
    super.initState();
  }

  void onStartUp() async {
    await appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              context.read<ThemeProvider>().isDarkMode
                  ? Assets.splashImageDarkMode
                  : Assets.splashImageDarkMode,
              scale: 2,
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 1500))
                .fadeOut(
                    delay: const Duration(milliseconds: 1750),
                    duration: const Duration(milliseconds: 1000)),
          )
        ],
      )),
    );
  }
}
