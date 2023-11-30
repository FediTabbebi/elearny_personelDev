import 'package:elearny/provider/adminProviders/admin_edit_social_links_provider.dart';
import 'package:elearny/provider/adminProviders/admin_edit_users_provider.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/authProviders/register_provider.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/provider/home_provider.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/provider/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/provider/SplashScreenProvider/splash_provider.dart';
import 'package:elearny/provider/quiz_provider/quiz_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/provider/userProvider/update_user_provider.dart';
import 'package:elearny/provider/widgetProviders/theme_mode_switcher_provider.dart';
import 'package:elearny/routes/app_pages.dart';
import 'package:elearny/services/app_service/app_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgetProviders/dropdownvalue_provider.dart';

class Providers extends StatelessWidget {
  final Widget child;
  final AppService appService;
  final SharedPreferences sharedPreferences;
  const Providers(
      {super.key,
      required this.child,
      required this.appService,
      required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceTypeProvider()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(
                appService: appService, sharedPreferences: sharedPreferences)),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeSwitcherProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => AdminAddLinkProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => AdminEditUsersProvider()),
        ChangeNotifierProvider(create: (_) => DropdownValue()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SubNavigationProvider()),
        ChangeNotifierProvider(create: (_) => AdminAddLinkProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
      ],
      child: child,
    );
  }
}
