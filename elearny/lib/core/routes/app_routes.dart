enum AppPage {
  onBoarding,
  splash,
  login,
  register,
  home,
  editLesson,
  settings,
  quiz,
  createOrUpdateQuiz,
  playQuiz,
  profile,
  accountSecurity,
  subscriptions,
  paymentMethod,
  notifications,
  privacy,
  editAppLinks,
  editUsers,
  error,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.home:
        return "/";
      case AppPage.onBoarding:
        return "/onboarding";
      case AppPage.splash:
        return "/splash";
      case AppPage.login:
        return "/login";

      case AppPage.register:
        return "/register";

      case AppPage.editLesson:
        return "/edit-lesson";
      case AppPage.quiz:
        return "/quiz";
      case AppPage.createOrUpdateQuiz:
        return "createQuiz";
      case AppPage.playQuiz:
        return "playQuiz";
      case AppPage.settings:
        return "/settings";
      case AppPage.profile:
        return "/settings/profile";
      case AppPage.accountSecurity:
        return "/settings/account-security";
      case AppPage.subscriptions:
        return "/settings/subscriptions";
      case AppPage.paymentMethod:
        return "/settings/payment-methods";
      case AppPage.notifications:
        return "/settings/notifications";
      case AppPage.privacy:
        return "/settings/privacy";
      case AppPage.editAppLinks:
        return "/edit-app-links";
      case AppPage.editUsers:
        return "/edit-users";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.home:
        return "home";
      case AppPage.onBoarding:
        return "onboarding";
      case AppPage.splash:
        return "splash";
      case AppPage.login:
        return "login";

      case AppPage.register:
        return "register";

      case AppPage.editLesson:
        return "edit-lesson";
      case AppPage.quiz:
        return "quiz";
      case AppPage.createOrUpdateQuiz:
        return "createQuiz";
      case AppPage.playQuiz:
        return "playQuiz";
      case AppPage.settings:
        return "settings";
      case AppPage.profile:
        return "profile";
      case AppPage.accountSecurity:
        return "accountSecurity";
      case AppPage.subscriptions:
        return "subscriptions";
      case AppPage.paymentMethod:
        return "paymentMethods";
      case AppPage.notifications:
        return "notifications";
      case AppPage.privacy:
        return "privacy";
      case AppPage.editAppLinks:
        return "editAppLinks";
      case AppPage.editUsers:
        return "editUsers";
      default:
        return "home";
    }
  }
}
