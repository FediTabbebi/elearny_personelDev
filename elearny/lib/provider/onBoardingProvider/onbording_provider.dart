import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnBoardingProvider extends ChangeNotifier {
  int selectedPageIndex = 0;
  bool get isLastPage => selectedPageIndex == contents.length - 1;
  PageController pageController = PageController();

  forwardAction() {
    pageController.nextPage(
        duration: 300.milliseconds, curve: Curves.easeInSine);
    selectedPageIndex++;

    notifyListeners();
  }

  skipAction() {
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);

    selectedPageIndex = contents.length - 1;
    notifyListeners();
  }
}

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome",
    image: "assets/images/onBoarding1.png",
    desc:
        """Welcome to elearny ! We're thrilled to have you join our community of learners. 
Get ready to embark on an exciting learning journey with us""",
  ),
  OnboardingContents(
    title: "Explore us",
    image: "assets/images/onBoarding2.png",
    desc: """Discover a world of knowledge with elearny.
Explore our wide range of courses designed to help you grow, learn, and succeed.""",
  ),
  OnboardingContents(
    title: "Get Started",
    image: "assets/images/onBoarding3.png",
    desc:
        """It's time to get started! Dive into your first course, expand your horizons, and achieve your learning goals with elearny.
Let's begin!""",
  ),
];
