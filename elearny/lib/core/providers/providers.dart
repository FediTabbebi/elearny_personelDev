import 'package:elearny/core/providers/admin_providers/admin_edit_social_links_provider.dart';
import 'package:elearny/core/providers/admin_providers/admin_edit_users_provider.dart';
import 'package:elearny/core/providers/auth_providers/login_provider.dart';
import 'package:elearny/core/providers/auth_providers/register_provider.dart';
import 'package:elearny/core/providers/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/core/providers/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/core/providers/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/core/providers/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/core/providers/quiz_provider/quiz_provider.dart';
import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/providers/userProvider/user_provider.dart';
import 'package:elearny/core/providers/userProvider/update_user_provider.dart';
import 'package:elearny/core/providers/app_service/app_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget child;
  const Providers({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceTypeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AdminUserManagementProvider()),
        ChangeNotifierProvider(create: (_) => AdminEditSocialLinksProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => SubNavigationProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
      ],
      child: child,
    );
  }
}
