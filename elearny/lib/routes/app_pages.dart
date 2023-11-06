import 'package:elearny/data/globales.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_add_links.dart';
import 'package:elearny/src/pages/home_mainPage.dart';
import 'package:elearny/src/pages/home_screen.dart';
import 'package:elearny/src/pages/lesson_editor.dart.dart';
import 'package:elearny/src/pages/login_screen.dart';
import 'package:elearny/src/pages/logout_screen.dart';
import 'package:elearny/src/pages/profile_screen.dart';
import 'package:elearny/src/pages/register_screen.dart';
import 'package:elearny/src/widgets/two_buttons_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splash:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => const SplashScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.onboarding:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => const OnBoardingScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.login:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => LoginScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.register:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => RegisterScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.home:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => HomeScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.profile:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => ProfileScreen(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.lessonEditor:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => LessonEditor(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       case Routes.adminLinks:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => AdminAddLinks(),
//           transitionsBuilder: (_, anim, __, child) =>
//               FadeTransition(opacity: anim, child: child),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/';

  // Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _sectionNavigatorKeyHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final a = GlobalKey<NavigatorState>(debugLabel: 'a');
  static final b = GlobalKey<NavigatorState>(debugLabel: 'b');
  static final c = GlobalKey<NavigatorState>(debugLabel: 'c');
  static final x = GlobalKey<NavigatorState>(debugLabel: 'x');

  // Go router Configuration
  static final GoRouter router = GoRouter(
    // debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: initRoute,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
          // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: HomeScreen(navigationShell: navigationShell));
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: x,
            routes: <RouteBase>[
              GoRoute(
                name: 'home',
                path: '/',
                builder: (BuildContext context, GoRouterState state) {
                  return HomeMain(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKeyHome,
            routes: <RouteBase>[
              GoRoute(
                name: 'profile',
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    ProfileScreen(
                  key: state.pageKey,
                ),

                // sub View
              ),
            ],
          ),

          // The route branch for 2º Tab
          StatefulShellBranch(
            navigatorKey: a,
            routes: <RouteBase>[
              GoRoute(
                name: 'lessonEditor',
                path: '/lessonEditor',
                builder: (BuildContext context, GoRouterState state) =>
                    LessonEditor(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          // The route branch for 3º Tab
          StatefulShellBranch(navigatorKey: c, routes: <RouteBase>[
            GoRoute(
              name: 'logout',
              path: '/logout',
              builder: (BuildContext context, GoRouterState state) {
                return LogoutScreen(
                  key: state.pageKey,
                );
              },
            ),
          ]),
          // The route branch for 4º Tab
          StatefulShellBranch(
            navigatorKey: b,
            routes: <RouteBase>[
              GoRoute(
                name: 'adminLinks',
                path: '/adminLinks',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminAddLinks(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
    ],

    redirect: (context, state) async {
      final User? user = await FirebaseAuth.instance.authStateChanges().first;

      AuthenticationServices getUser = AuthenticationServices();
      if (kDebugMode) {
        print("user");
      }
      if (kDebugMode) {
        print(user?.email);
      }

      // Check if the user is authenticated
      if (user != null) {
        if (kDebugMode) {
          print("ok");
        }
        await getUser
            .getCurrentUser(user.uid)
            .then((value) => globalUser = value);
        // globalUser.
        return null;
      }
      // If the user is not authenticated or has no role, redirect to the login page
      if (kDebugMode) {
        print("not ok");
      }
      return '/login';
    },
  );
}

Future<void> showingDialog(BuildContext context) async {
  await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return TwoButtonsDialogWidget(
          title: 'Exit Confirmation',
          contents: "Are you sure you want to exit the app ?",
          confirmbuttonText: 'Confirm',
          declinebuttonText: 'Back',
          onConfirm: () {
            SystemNavigator.pop();
          },
          onDecline: () {
            Navigator.of(context).pop();
          },
        );
      });
}
