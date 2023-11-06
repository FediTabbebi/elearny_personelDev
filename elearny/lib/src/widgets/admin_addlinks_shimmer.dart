import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAddLinksShimmerWidget extends StatelessWidget {
  const AdminAddLinksShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Wrap(
                  children: [
                    mainPagePictureWidget(context),
                    mainPagePictureWidget(context),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              textField(
                context,
              ),
              const SizedBox(
                height: 16,
              ),
              downloadApp(
                context,
              ),
              downloadApp(
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainPagePictureWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: deviceType != 1
              ? deviceType == 2
                  ? 220
                  : 200
              : 260,
          width: deviceType != 1
              ? deviceType == 2
                  ? 340
                  : 280
              : 400,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: deviceType != 1
                    ? deviceType == 2
                        ? 160
                        : 140
                    : 200,
                width: deviceType != 1
                    ? deviceType == 2
                        ? 340
                        : 280
                    : 400,
                child: Card(
                  elevation: 0.5,
                  color: context.read<ThemeProvider>().isDarkMode
                      ? Themes.darkMode
                      : const Color(0xffE9E8E3),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        color: context.read<ThemeProvider>().isDarkMode
                            ? Themes.darkMode
                            : const Color(0xffE9E8E3),
                        borderRadius: BorderRadius.circular(5)),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget textField(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 10),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: context.read<ThemeProvider>().isDarkMode
                      ? Themes.darkMode
                      : const Color(0xffE9E8E3),
                  shape: BoxShape.circle),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWidget(context)),
          ),
        ],
      ),
    );
  }

  Widget downloadApp(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 20.0, left: 10),
              child: SizedBox(
                width: 160,
                height: 65,
                child: Card(
                  color: context.read<ThemeProvider>().isDarkMode
                      ? Themes.darkMode
                      : const Color(0xffE9E8E3),
                ),
              )),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWidget(context)),
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: context.read<ThemeProvider>().isDarkMode
              ? Themes.darkMode
              : const Color(0xffE9E8E3),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
