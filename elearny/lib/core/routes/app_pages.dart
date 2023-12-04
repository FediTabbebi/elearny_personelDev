import 'package:elearny/core/models/quiz_model.dart';
import 'package:elearny/core/routes/app_routes.dart';
import 'package:elearny/core/providers/app_service/app_service.dart';
import 'package:elearny/locator.dart';
import 'package:elearny/ui/pages/admin_pages/admin_edit_social_links.dart';
import 'package:elearny/ui/pages/admin_pages/admin_edit_users.dart';
import 'package:elearny/ui/pages/error_page.dart';
import 'package:elearny/ui/pages/home_main_page.dart';
import 'package:elearny/ui/pages/home_screen.dart';
import 'package:elearny/ui/pages/lesson_editor.dart.dart';
import 'package:elearny/ui/pages/auth_pages/login_screen.dart';
import 'package:elearny/ui/pages/quiz/create_update_quiz.dart';
import 'package:elearny/ui/pages/quiz/play_quiz.dart';
import 'package:elearny/ui/pages/quiz/quiz_screen.dart';
import 'package:elearny/ui/pages/sidebar_pages/setting_main_screen.dart';
import 'package:elearny/ui/pages/onbording_screen.dart';
import 'package:elearny/ui/pages/sidebar_pages/profile_screen.dart';
import 'package:elearny/ui/pages/auth_pages/register_screen.dart';
import 'package:elearny/ui/pages/setting_screen.dart';
import 'package:elearny/ui/pages/sidebar_pages/account_security.dart';
import 'package:elearny/ui/pages/sidebar_pages/notifications.dart';
import 'package:elearny/ui/pages/sidebar_pages/payment_methods.dart';
import 'package:elearny/ui/pages/sidebar_pages/privacy.dart';
import 'package:elearny/ui/pages/sidebar_pages/subscriptions.dart';
import 'package:elearny/ui/pages/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final AppService appService = locator<AppService>();
  static final sectionNavigatorKeyHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final subSectionNavigatorKeyHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettingHome');

  // Go router Configuration
  static final GoRouter router = GoRouter(
      // debugLogDiagnostics: true,
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
                    kIsWeb ? AppPage.profile.toPath : AppPage.profile.toPath,
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
                    return AdminUserManagementScreen(
                      key: state.pageKey,
                    );
                  },
                ),
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
                        name: AppPage.createOrUpdateQuiz.toName,
                        path: AppPage.createOrUpdateQuiz.toPath,
                        builder: (BuildContext context, GoRouterState state) {
                          final QuizModel? quizModel =
                              state.extra as QuizModel?;
                          return CreateOrUpdateQuizScreen(
                            key: state.pageKey,
                            quizModel: quizModel,
                          );
                        },
                      ),
                      GoRoute(
                        name: AppPage.playQuiz.toName,
                        path: AppPage.playQuiz.toPath,
                        builder: (BuildContext context, GoRouterState state) {
                          final String quizUrl = state.extra as String;
                          return PlayQuizScreen(
                            key: state.pageKey,
                            quizUrl: quizUrl,
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
      redirect: (context, state) async =>
          appService.redirectionHandler(context, state));
}
