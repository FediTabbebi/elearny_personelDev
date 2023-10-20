import 'package:elearny/firebase_options.dart';
import 'package:elearny/provider/providers.dart';
import 'package:elearny/utils/responsive_helper.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:elearny/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Providers(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      ResponsiveHelper.handleResponsive(
          context, sizingInformation.deviceScreenType);
      return ScreenUtilInit(
          designSize: const Size(1920, 1080),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return MaterialApp(
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                initialRoute: '/',
                onGenerateRoute: RouteGenerator.generateRoute);
          });
    });
  }
}
