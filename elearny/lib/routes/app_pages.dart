import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/app_service/app_service.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_add_links.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_edit_users.dart';
import 'package:elearny/src/pages/error_page.dart';
import 'package:elearny/src/pages/home_main_page.dart';
import 'package:elearny/src/pages/home_screen.dart';
import 'package:elearny/src/pages/lesson_editor.dart.dart';
import 'package:elearny/src/pages/auth_pages/login_screen.dart';
import 'package:elearny/src/pages/quiz/create_quiz.dart';
import 'package:elearny/src/pages/quiz/play_quiz.dart';
import 'package:elearny/src/pages/quiz/quiz_screen.dart';
import 'package:elearny/src/pages/sideBarPages/setting_main_screen.dart';
import 'package:elearny/src/pages/onbording_screen.dart';
import 'package:elearny/src/pages/sideBarPages/profile_screen.dart';
import 'package:elearny/src/pages/auth_pages/register_screen.dart';
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

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final AuthenticationServices getUser = AuthenticationServices();
  static final sectionNavigatorKeyHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final subSectionNavigatorKeyHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettingHome');

  // Go router Configuration
  late final GoRouter _goRouter = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: AppPage.home.toPath,
      refreshListenable: appService,
      routes: <RouteBase>[
        GoRoute(
          name: AppPage.login.toName,
          path: AppPage.login.toPath,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
        GoRoute(
          name: AppPage.register.toName,
          path: AppPage.register.toPath,
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterScreen(),
        ),
        GoRoute(
          name: AppPage.splash.toName,
          path: AppPage.splash.toPath,
          builder: (BuildContext context, GoRouterState state) => SplashScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: AppPage.onBoarding.toName,
          path: AppPage.onBoarding.toPath,
          builder: (BuildContext context, GoRouterState state) =>
              OnBoardingScreen(
            key: state.pageKey,
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: sectionNavigatorKeyHome,
              routes: <RouteBase>[
                GoRoute(
                  name: AppPage.home.toName,
                  path: AppPage.home.toPath,
                  builder: (context, state) => const HomeMain(),
                ),
              ],
            ),

            // The route branch for 2º Tab
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: AppPage.editLesson.toName,
                  path: AppPage.editLesson.toPath,
                  builder: (BuildContext context, GoRouterState state) =>
                      LessonEditor(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
            // The route branch for 3º Tab

            StatefulShellBranch(
                initialLocation:
                    kIsWeb ? AppPage.profile.toPath : AppPage.settings.toPath,
                routes: [
                  GoRoute(
                    name: AppPage.settings.toName,
                    path: AppPage.settings.toPath,
                    builder: (BuildContext context, GoRouterState state) {
                      return SettingScreen(
                        key: state.pageKey,
                      );
                    },
                  ),
                  StatefulShellRoute.indexedStack(
                      builder: (context, state, navigationShell) {
                        return SettingPage(navigationShell: navigationShell);
                      },
                      branches: [
                        StatefulShellBranch(
                          navigatorKey: subSectionNavigatorKeyHome,
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.profile.toName,
                              path: AppPage.profile.toPath,
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      ProfileScreen(
                                key: state.pageKey,
                              ),
                            ),
                          ],
                        ),
                        StatefulShellBranch(
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.accountSecurity.toName,
                              path: AppPage.accountSecurity.toPath,
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      AccountSecurityScreen(
                                key: state.pageKey,
                              ),
                            ),
                          ],
                        ),
                        StatefulShellBranch(
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.subscriptions.toName,
                              path: AppPage.subscriptions.toPath,
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      SubScriptionsScreen(
                                key: state.pageKey,
                              ),
                            ),
                          ],
                        ),
                        StatefulShellBranch(
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.paymentMethod.toName,
                              path: AppPage.paymentMethod.toPath,
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      PaymentMedthodScreen(
                                key: state.pageKey,
                              ),
                            ),
                          ],
                        ),
                        StatefulShellBranch(
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.notifications.toName,
                              path: AppPage.notifications.toPath,
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      NotificationsScreen(
                                key: state.pageKey,
                              ),
                            ),
                          ],
                        ),
                        StatefulShellBranch(
                          routes: <RouteBase>[
                            GoRoute(
                              name: AppPage.privacy.toName,
                              path: AppPage.privacy.toPath,
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
              routes: <RouteBase>[
                GoRoute(
                  name: AppPage.editAppLinks.toName,
                  path: AppPage.editAppLinks.toPath,
                  builder: (BuildContext context, GoRouterState state) {
                    return AdminAddLinks(
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                    name: AppPage.editUsers.toName,
                    path: AppPage.editUsers.toPath,
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
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                    name: AppPage.quiz.toName,
                    path: AppPage.quiz.toPath,
                    builder: (BuildContext context, GoRouterState state) {
                      return QuizScreen(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      GoRoute(
                        name: AppPage.createQuiz.toName,
                        path: AppPage.createQuiz.toPath,
                        builder: (BuildContext context, GoRouterState state) {
                          return CreateQuizScreen(
                            key: state.pageKey,
                          );
                        },
                      ),
                      GoRoute(
                        name: AppPage.playQuiz.toName,
                        path: AppPage.playQuiz.toPath,
                        builder: (BuildContext context, GoRouterState state) {
                          return PlayQuizScreen(
                            key: state.pageKey,
                          );
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) =>
          ErrorPage(error: state.error.toString()),
      redirect: (context, state) async {
        final User? user = await FirebaseAuth.instance.authStateChanges().first;

        final loginLocation = state.namedLocation(AppPage.login.toName);
        final homeLocation = state.namedLocation(AppPage.home.toName);
        final splashLocation = state.namedLocation(AppPage.splash.toName);
        final onboardLocation = state.namedLocation(AppPage.onBoarding.toName);
        final registerLocation = state.namedLocation(AppPage.register.toName);

        final isLogedIn = user != null;
        final isInitialized = appService.initialized;
        final isOnboarded = appService.onboarding;

        final isGoingToInit = state.matchedLocation == splashLocation;
        final isGoingToLogin = state.matchedLocation == loginLocation;

        final isGoingToOnboard = state.matchedLocation == onboardLocation;
        final isGoingToRegister = state.matchedLocation == registerLocation;

        if (!kIsWeb) {
          // If not Initialized and not going to Initialized redirect to Splash
          if (!isInitialized && !isGoingToInit) {
            return splashLocation;
          }
          // If not onboard and not going to onboard redirect to OnBoarding
          else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
            return onboardLocation;
          }
          // If not logedin and not going to login redirect to Login
          else if (isInitialized &&
              isOnboarded &&
              !isLogedIn &&
              !isGoingToLogin) {
            if (isGoingToRegister) {
              return registerLocation;
            }
            return loginLocation;
          }
          // If all the scenarios are cleared but still going to any of that screen redirect to Home
          else if ((isLogedIn && isGoingToLogin) ||
              (isInitialized && isGoingToInit) ||
              (isOnboarded && isGoingToOnboard)) {
            await getUser.getCurrentUser(user!.uid).then(
                (value) => context.read<UserProvider>().updateUser(value));
            return homeLocation;
          } else {
            // Else Don't do anything
            return null;
          }
        } else {
          if (isLogedIn) {
            await getUser.getCurrentUser(user.uid).then(
                (value) => context.read<UserProvider>().updateUser(value));

            if (isGoingToLogin) {
              return homeLocation;
            }
            return null;
          } else if (isGoingToRegister) {
            return registerLocation;
          }
          return loginLocation;
        }
      });
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
