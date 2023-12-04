import 'package:elearny/firebase_options.dart';
import 'package:elearny/provider/providers.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';

import 'package:elearny/src/utils/responsive_helper.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:elearny/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/app_service/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GoRouter.optionURLReflectsImperativeAPIs = true;
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({required this.sharedPreferences, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;
  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    appService.authNotifier();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Providers(
      appService: appService,
      sharedPreferences: widget.sharedPreferences,
      child: ResponsiveBuilder(builder: (context, sizingInformation) {
        ResponsiveHelper.handleResponsive(
            context, sizingInformation.deviceScreenType);
        return ScreenUtilInit(
            designSize: const Size(1920, 1080),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              final GoRouter goRouter =
                  Provider.of<AppRouter>(context, listen: false).router;
              context.read<ThemeProvider>().initSystemMode();
              return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: Provider.of<ThemeProvider>(
                    context,
                  ).getThemeData(),

                  // routeInformationProvider:
                  //     AppRouter.router.routeInformationProvider,
                  // routeInformationParser: AppRouter.router.routeInformationParser,
                  // routerDelegate: AppRouter.router.routerDelegate,
                  // initialRoute: Routes.splash,
                  // onGenerateRoute: RouteGenerator.generateRoute
                  //routerConfig: AppNavigation.router,.

                  routerDelegate: goRouter.routerDelegate,
                  routeInformationProvider: goRouter.routeInformationProvider,
                  routeInformationParser: goRouter.routeInformationParser);
            });
      }),
    );
  }
}
