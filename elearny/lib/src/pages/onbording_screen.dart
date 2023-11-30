import 'package:elearny/provider/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/services/app_service/app_service.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
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
                    onboardingProvider.animateToPage(index, 300);
                    print(onboardingProvider.selectedPageIndex);
                    //  onboardingProvider.selectedPageIndex = index;
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
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color!,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            contents[i].desc,
                            style: const TextStyle(
                                color: Themes.grey, fontSize: 14),
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
                                appService.onboarding = true;
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
                                  print(onboardingProvider.selectedPageIndex);
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
                                        horizontal: 30, vertical: 25),
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
        height: 10,
        curve: Curves.easeIn,
        width: onBoardingProvider.selectedPageIndex == index ? 20 : 10);
  }
}
