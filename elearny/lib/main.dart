import 'package:elearny/core/utils/shared_preference_utils.dart';
import 'package:elearny/firebase_options.dart';
import 'package:elearny/core/providers/providers.dart';
import 'package:elearny/core/providers/themeProvider/theme_provider.dart';

import 'package:elearny/core/utils/responsive_helper.dart';
import 'package:elearny/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:elearny/core/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'core/providers/app_service/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setupLocator();
  locator<SharedPrefs>().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppService appService;
  @override
  void initState() {
    super.initState();
    appService = locator<AppService>();
    appService.authNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Providers(
        child: ResponsiveBuilder(builder: (context, sizingInformation) {
      ResponsiveHelper.handleResponsive(
          context, sizingInformation.deviceScreenType);
      context.watch<ThemeProvider>().isDarkMode;
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(
          context,
        ).getThemeData(),
        routerConfig: AppNavigation.router,
      );
    }));
  }
}
