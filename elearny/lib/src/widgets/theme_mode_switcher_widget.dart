import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';

import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeSwitcherWidget extends StatelessWidget {
  final double? currentWidth;
  ThemeModeSwitcherWidget({super.key, this.currentWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: AnimatedToggleSwitch<bool>.size(
        current: context.watch<ThemeProvider>().isDarkMode,
        values: const [false, true],
        iconOpacity: 0.2,
        indicatorSize: Size.fromWidth(
          currentWidth! > 190 ? 90 : 75,
        ),
        customIconBuilder: (context, local, global) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Icon(
                local.value ? Icons.dark_mode : Icons.sunny,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                size: currentWidth! > 190 ? 25 : 17,
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: currentWidth! > 190
                    ? 50
                    : currentWidth! < 100
                        ? 0
                        : 30,
                child: AutoSizeText(
                  local.value ? "Dark " : "Light ",
                  minFontSize: 6,
                  maxFontSize: 16,
                  maxLines: 1, // Set the maximum number of lines
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ],
          );
        },
        borderWidth: 4.0,
        iconAnimationType: AnimationType.onHover,
        style: ToggleStyle(
          indicatorColor: Theme.of(context).textTheme.labelLarge!.color,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(60.0),
          // boxShadow: [
          //   const BoxShadow(
          //     color: Colors.black26,
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: Offset(0, 1.5),
          //   ),
          // ],
          backgroundColor: context.watch<ThemeProvider>().isDarkMode
              ? Themes.darkMode
              : const Color(0xffD9D9D9),
        ),
        selectedIconScale: 1.0,
        onChanged: (onChanged) {
          //  context.read<ThemeModeSwitcherProvider>().chnageState(b);
          context.read<ThemeProvider>().toggleTheme();
        },
      ),
    );
  }
}

class ThemeModeSwitcherWidgetSmall extends StatelessWidget {
  const ThemeModeSwitcherWidgetSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<ThemeProvider>().toggleTheme();
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: context.read<ThemeProvider>().isDarkMode
                  ? Themes.darkMode
                  : const Color(0xffD9D9D9),
            ),
            height: 45,
            width: 45,
            child: Icon(
              context.read<ThemeProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.sunny,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              key: UniqueKey(),
            )));
  }
}
