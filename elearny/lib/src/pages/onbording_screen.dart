import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/onBoardingProvider/onbording_provider.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                flex: deviceType == 2 ? 5 : 5,
                child: PageView.builder(
                  physics: const PageScrollPhysics(),
                  controller: onboardingProvider.pageController,
                  onPageChanged: (index) {
                    onboardingProvider.selectedPageIndex = index;
                  },
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Column(
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
                        Text(
                          contents[i].desc,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                //flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    onboardingProvider.isLastPage
                        ? Padding(
                            padding: const EdgeInsets.all(30),
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.login);
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
                                    (int index) => _buildDots(
                                        index: index,
                                        onBoardingProvider: onboardingProvider),
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
