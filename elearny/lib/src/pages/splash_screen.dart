import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/services/app_service/app_service.dart';
import 'package:elearny/src/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppService _appService;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();
    super.initState();
  }

  void onStartUp() async {
    await _appService.onAppStart();
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
              scale: 2.h.w,
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
