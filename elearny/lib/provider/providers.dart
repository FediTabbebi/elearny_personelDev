import 'package:elearny/provider/adminProviders/add_links_provider.dart';
import 'package:elearny/provider/adminProviders/admin_edit_users_provider.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/authProviders/register_provider.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/provider/home_provider.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/provider/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/provider/SplashScreenProvider/splash_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/provider/userProvider/update_user_provider.dart';
import 'package:elearny/provider/widgetProviders/theme_mode_switcher_provider.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgetProviders/dropdownvalue_provider.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceTypeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        Provider<AuthenticationServices>(
          create: (_) => AuthenticationServices(),
        ),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeSwitcherProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
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
