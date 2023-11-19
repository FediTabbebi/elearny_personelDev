import 'package:elearny/provider/userProvider/auth_notifier.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final AuthenticationServices getUser = AuthenticationServices();
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
  static final AuthNotifier authStateNotifier = AuthNotifier();

  // Go router Configuration
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: initRoute,
    refreshListenable: authStateNotifier,
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
      // GoRoute(
      //   name: 'onBoarding',
      //   path: '/onBoarding',
      //   builder: (BuildContext context, GoRouterState state) =>
      //       OnBoardingScreen(
      //     key: state.pageKey,
      //   ),
      // ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKeyHome,
            routes: <RouteBase>[
              GoRoute(
                name: 'home',
                path: '/',
                builder: (context, state) => const HomeMain(),
                // redirect: (context, state) {
                //   print(state.matchedLocation);
                //   if (state.matchedLocation == '/') {
                //     print("eeeeeeeeeeeeeeeee");
                //   }
                //   return null;
                // },
                // onExit: (BuildContext context) async {
                //   return false;
                // }
              ),
            ],
          ),

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
              initialLocation: kIsWeb ? '/Settings/Profile' : '/Settings',
              navigatorKey: c,
              routes: [
                GoRoute(
                  name: 'Settings',
                  path: '/Settings',
                  builder: (BuildContext context, GoRouterState state) {
                    return SettingScreen(
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
                          ),
                        ],
                      ),
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
                    print("Exiting edit-users'");
                    return true;
                  }),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final User? user = await FirebaseAuth.instance.authStateChanges().first;

      // Check the authentication state using Firebase and redirect accordingly

      if (user != null) {
        print("redirecting user != null");
        await getUser
            .getCurrentUser(user.uid)
            .then((value) => context.read<UserProvider>().updateUser(value));
        if (state.matchedLocation == '/login') {
          print("redirecting login");
          return '/';
        }
        return null;
      } else if (state.matchedLocation == '/register') {
        return '/register';
      }

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
