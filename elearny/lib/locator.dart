import 'package:elearny/core/provider/authProviders/register_provider.dart';

import 'package:elearny/core/provider/quiz_provider/quiz_provider.dart';
import 'package:elearny/core/provider/userProvider/user_provider.dart';
import 'package:elearny/core/providers/admin_providers/admin_edit_social_links_provider.dart';
import 'package:elearny/core/providers/admin_providers/admin_edit_users_provider.dart';
import 'package:elearny/core/providers/app_service/app_service.dart';
import 'package:elearny/core/providers/auth_providers/login_provider.dart';
import 'package:elearny/core/providers/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/core/providers/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/core/providers/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/core/providers/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/providers/userProvider/update_user_provider.dart';
import 'package:elearny/core/utils/shared_preference_utils.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() {
    return AppService();
  });

  locator.registerLazySingleton(() => SharedPrefs());
  locator.registerLazySingleton(() => DeviceTypeProvider());
  locator.registerLazySingleton(() => ThemeProvider());

  locator.registerLazySingleton(() => UserProvider());
  locator.registerLazySingleton(() => OnBoardingProvider());
  locator.registerLazySingleton(() => RegisterProvider());
  locator.registerLazySingleton(() => LoginProvider());
  locator.registerLazySingleton(() => NavigationProvider());
  locator.registerLazySingleton(() => AdminUserManagementProvider());
  locator.registerLazySingleton(() => AdminEditSocialLinksProvider());
  locator.registerLazySingleton(() => QuizProvider());
  locator.registerLazySingleton(() => SubNavigationProvider());
  locator.registerLazySingleton(() => UpdateUserProvider());
}
