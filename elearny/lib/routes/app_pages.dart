import 'package:elearny/src/pages/login_screen.dart';
import 'package:elearny/src/pages/register_screen.dart';
import 'package:elearny/src/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
// static GoRouter router() {
//     return GoRouter(
//     initialLocation: '/splash',
//     errorPageBuilder: (context, state) => const MaterialPage(child: Text('Error!')),
//       routes: [
//         GoRoute(
//           path: '/splash',
//           pageBuilder: (context, state) => const MaterialPage(child: SplashScreen()),
//         ),
//         GoRoute(
//           path: '/signup',
//           pageBuilder: (context, state) => MaterialPage(child: SignUpScreen()),
//         ),
     
//       ],
//     );
//   }