import 'package:elearny/data/globales.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final IconData? leftIcon;

  final Widget? leftWidget;
  final VoidCallback? onPressedLeftIcon;
  final String? title;
  final bool? centerTitle;
  final String? subtitle;
  final IconData? rightIcon;
  final Widget? rightWidget;
  final VoidCallback? onPressedRightIcon;

  const AppBarWidget(
      {super.key,
      required this.leftIcon,
      this.leftWidget,
      this.onPressedLeftIcon,
      required this.title,
      this.centerTitle,
      required this.subtitle,
      required this.rightIcon,
      this.rightWidget,
      this.onPressedRightIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: centerTitle == null
          ? MainAxisAlignment.start
          : (rightWidget == null &&
                  rightIcon == null &&
                  leftIcon == null &&
                  leftWidget == null)
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        leftIcon != null
            ? Container(
                height: 30,
                width: 70,
                color: Theme.of(context).scaffoldBackgroundColor,
              )
            // ? ElevatedButton(
            //     onPressed: () {
            //       onPressedLeftIcon!();
            //       // Scaffold.of(context).openDrawer(); // Open the drawer
            //     },
            //     style: ElevatedButton.styleFrom(
            //       elevation: 1,
            //       shape: const CircleBorder(),
            //       padding: const EdgeInsets.all(10),
            //       backgroundColor:
            //           Theme.of(context).textTheme.titleSmall!.color,
            //     ),
            //     child: Icon(
            //       leftIcon!,
            //       // Icons.menu,
            //       color: Themes.grey,
            //       size: deviceType != 1
            //           ? deviceType == 2
            //               ? 30
            //               : 30
            //           : 40,
            //     ),
            //   )
            : const SizedBox(
                width: 1,
              ),
        Column(
            crossAxisAlignment: centerTitle == null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: centerTitle == null ? null : TextAlign.center,
              ),
              const SizedBox(
                height: 3,
              ),
              subtitle != null
                  ? SizedBox(
                      width: kIsWeb
                          ? MediaQuery.of(context).size.width / 2.1
                          : (rightWidget == null && rightIcon == null)
                              ? MediaQuery.of(context).size.width / 1.4
                              : MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        subtitle!,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign:
                            centerTitle == null ? null : TextAlign.center,
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ]),
        rightIcon != null
            ? ElevatedButton(
                onPressed: () {
                  onPressedRightIcon!();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor:
                      Theme.of(context).textTheme.titleSmall!.color,
                ),
                child: Icon(
                  rightIcon!,
                  // Icons.discount,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  size: deviceType != 1
                      ? deviceType == 2
                          ? 40
                          : 30
                      : 40,
                ),
              )
            : const SizedBox(
                width: 0,
              ),
        rightWidget ??
            const SizedBox(
              width: 0,
            )
      ],
    );
  }
}
