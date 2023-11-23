import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePlaceHolder extends StatelessWidget {
  ProfilePlaceHolder({
    super.key,
  });

  final PageController pageController = PageController();

  final List<String> myList = [
    "assets/images/manPlaceHolder.png",
    "assets/images/womanPlaceHolder.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemCount: null,
                itemBuilder: (context, index) {
                  final realIndex = index % 2;
                  return Image.asset(
                    myList[realIndex],
                    scale: deviceType != 1
                        ? deviceType == 2
                            ? 1.8
                            : 2
                        : 1.25,
                  );
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut);
                //  Get.back();
              },
              child: Icon(
                FontAwesomeIcons.chevronRight,
                // color: Theme.of(context).textTheme.displaySmall!.color,
                // color: Theme.of(context).textTheme.labelMedium!.color,
                color: Themes.grey,

                size: deviceType != 1
                    ? deviceType == 2
                        ? 30
                        : 20
                    : 40,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut);
                //  Get.back();
              },
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                //color: Theme.of(context).textTheme.displaySmall!.color,
                // color: Theme.of(context).textTheme.labelMedium!.color,
                //  color: Colors.white,
                color: Themes.grey,

                size: deviceType != 1
                    ? deviceType == 2
                        ? 30
                        : 20
                    : 40,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ElevatedButton(
          //       child: const Text(
          //         "Pick Image",
          //       ),
          //       onPressed: () {
          //         context.read<UpdateUserProvider>().pickImage();
          //       }),
          // ),
        ],
      ),
    );
  }
}
