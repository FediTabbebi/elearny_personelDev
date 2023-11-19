import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<OnBoardingProvider>(
            builder: (context, onboardingProvider, _) {
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: onboardingProvider.pageController,
                  onPageChanged: (index) {
                    onboardingProvider.selectedPageIndex = index;
                  },
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          contents[i].image,
                          width: 300,
                          height: 300,
                          //scale: 2,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            contents[i].desc,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  onboardingProvider.isLastPage
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pushReplacement('/login');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text("START"),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  onboardingProvider.skipAction();
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                  (int index) => GestureDetector(
                                    onTap: () {
                                      if (index == contents.length - 1) {
                                        onboardingProvider.animateToPage(
                                            index, 650);
                                      } else {
                                        onboardingProvider.animateToPage(
                                            index, 300);
                                      }
                                    },
                                    child: _buildDots(
                                        index: index,
                                        onBoardingProvider: onboardingProvider),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  onboardingProvider.forwardAction();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    textStyle: const TextStyle()),
                                child: const Text("NEXT"),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  AnimatedContainer _buildDots(
      {int? index, required OnBoardingProvider onBoardingProvider}) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            color: Themes.green),
        margin: const EdgeInsets.only(right: 5),
        height: deviceType == 2 ? 15 : 10,
        curve: Curves.easeIn,
        width: onBoardingProvider.selectedPageIndex == index
            ? deviceType == 2
                ? 25
                : 20
            : deviceType == 2
                ? 15
                : 10);
  }
}
