import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/adminProviders/admin_edit_users_provider.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_add_links.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_edit_users.dart';
import 'package:elearny/src/pages/home_main_page.dart';
import 'package:elearny/src/pages/home_screen.dart';
import 'package:elearny/src/pages/lesson_editor.dart.dart';
import 'package:elearny/src/pages/login_screen.dart';
import 'package:elearny/src/pages/logout_screen.dart';
import 'package:elearny/src/pages/sideBarPages/profile_screen.dart';
import 'package:elearny/src/pages/register_screen.dart';
import 'package:elearny/src/pages/setting_screen.dart';
import 'package:elearny/src/pages/sideBarPages/account_security.dart';
import 'package:elearny/src/pages/sideBarPages/notifications.dart';
import 'package:elearny/src/pages/sideBarPages/payment_methods.dart';
import 'package:elearny/src/pages/sideBarPages/privacy.dart';
import 'package:elearny/src/pages/sideBarPages/subscriptions.dart';
import 'package:elearny/src/pages/splash_screen.dart';
import 'package:elearny/src/widgets/two_buttons_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  static final d = GlobalKey<NavigatorState>(debugLabel: 'd');
  static final e = GlobalKey<NavigatorState>(debugLabel: 'e');
  static final f = GlobalKey<NavigatorState>(debugLabel: 'f');
  static final g = GlobalKey<NavigatorState>(debugLabel: 'g');
  static final h = GlobalKey<NavigatorState>(debugLabel: 'h');
  static final i = GlobalKey<NavigatorState>(debugLabel: 'i');
  static final j = GlobalKey<NavigatorState>(debugLabel: 'j');
  static final k = GlobalKey<NavigatorState>(debugLabel: 'k');

  // Go router Configuration
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: initRoute,
    routes: <RouteBase>[
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (BuildContext context, GoRouterState state) => RegisterScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'spalsh',
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: HomeScreen(navigationShell: navigationShell));
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKeyHome,
            routes: <RouteBase>[
              GoRoute(
                  name: 'home',
                  path: '/',
                  pageBuilder: (context, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: HomeMain(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                ScaleTransition(scale: animation, child: child),
                      )),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: a,
          //   routes: <RouteBase>[
          //     GoRoute(
          //       name: 'profile',
          //       path: '/profile',
          //       builder: (BuildContext context, GoRouterState state) =>
          //           ProfileScreen(
          //         key: state.pageKey,
          //       ),

          //       // sub View
          //     ),
          //   ],
          // ),

          // The route branch for 2º Tab
          StatefulShellBranch(
            navigatorKey: b,
            routes: <RouteBase>[
              GoRoute(
                name: 'lessonEditor',
                path: '/edit-lessons',
                builder: (BuildContext context, GoRouterState state) =>
                    LessonEditor(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          // The route branch for 3º Tab
          StatefulShellBranch(
              initialLocation: '/Settings/Profile',
              navigatorKey: c,
              routes: [
                GoRoute(
                  name: 'setting',
                  path: '/setting',
                  builder: (BuildContext context, GoRouterState state) {
                    return LogoutScreen(
                      key: state.pageKey,
                    );
                  },
                ),
                StatefulShellRoute.indexedStack(
                    parentNavigatorKey: c,
                    builder: (context, state, navigationShell) {
                      return SettingPage(navigationShell: navigationShell);
                    },
                    branches: [
                      StatefulShellBranch(
                        navigatorKey: d,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'profile',
                            path: '/Settings/Profile',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    ProfileScreen(
                              key: state.pageKey,
                            ),
                            // onExit: (BuildContext context) async {
                            //   await showingDialog(context);
                            //   return true;
                            // }
                            // sub View
                          ),
                        ],
                      ),

                      // The route branch for 2º Tab
                      StatefulShellBranch(
                        navigatorKey: e,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'accountSecurity',
                            path: '/Settings/AccountSecurity',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    AccountSecurityScreen(
                              key: state.pageKey,
                            ),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        navigatorKey: f,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'subscriptions',
                            path: '/Settings/Subscriptions',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    SubScriptionsScreen(
                              key: state.pageKey,
                            ),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        navigatorKey: g,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'paymentMethod',
                            path: '/Settings/PaymentMethod',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    PaymentMedthodScreen(
                              key: state.pageKey,
                            ),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        navigatorKey: h,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'notification',
                            path: '/Settings/Notification',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    NotificationsScreen(
                              key: state.pageKey,
                            ),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        navigatorKey: i,
                        routes: <RouteBase>[
                          GoRoute(
                            name: 'privacy',
                            path: '/Settings/Privacy&Security',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    PrivacyScreen(
                              key: state.pageKey,
                            ),
                          ),
                        ],
                      ),
                    ])
              ]),

          StatefulShellBranch(
            navigatorKey: j,
            routes: <RouteBase>[
              GoRoute(
                name: 'edit-app-Links',
                path: '/edit-app-Links',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminAddLinks(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: k,
            routes: <RouteBase>[
              GoRoute(
                  name: 'editusers',
                  path: '/edit-users',
                  builder: (BuildContext context, GoRouterState state) {
                    return AdminEditUserScreen(
                      key: state.pageKey,
                    );
                  },
                  onExit: (BuildContext context) async {
                    //  context.read<AdminEditUsersProvider>().initi();
                    print("on exit === true ");
                    return true;
                  }),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final User? user = await FirebaseAuth.instance.authStateChanges().first;

      AuthenticationServices getUser = AuthenticationServices();
      // if (kDebugMode) {
      //   print("user");
      // }
      // if (kDebugMode) {
      //   print(user?.email);
      // }

      // Check if the user is authenticated
      if (user != null) {
        // if (kDebugMode) {
        //   print("ok");
        // }
        await getUser
            .getCurrentUser(user.uid)
            .then((value) => globalUser = value);
        // globalUser.
        return null;
      } else if (state.matchedLocation == '/register') {
        return '/register';
      }
      // If the user is not authenticated or has no role, redirect to the login page
      // if (kDebugMode) {
      //   print("not ok");
      // }
      return '/login';
    },
  );
}

// Future<void> showingDialog(BuildContext context) async {
//   await showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return TwoButtonsDialogWidget(
//           title: 'Exit Confirmation',
//           contents: "Are you sure you want to exit the app ?",
//           confirmbuttonText: 'Confirm',
//           declinebuttonText: 'Back',
//           onConfirm: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pop();
//           },
//           onDecline: () {
//             Navigator.of(context).pop();
//           },
//         );
//       });
// }
