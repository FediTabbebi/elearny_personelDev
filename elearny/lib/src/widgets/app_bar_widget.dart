import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  final IconData? leftIcon;
  final VoidCallback? onPressedLeftIcon;
  final String? title;
  final String? subtitle;
  final IconData? rightIcon;
  final VoidCallback? onPressedRightIcon;

  const AppBarWidget(
      {super.key,
      required this.leftIcon,
      this.onPressedLeftIcon,
      required this.title,
      required this.subtitle,
      required this.rightIcon,
      this.onPressedRightIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: title != null
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
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
                width: 60,
              ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title!,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 3,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Text(
              subtitle!,
              overflow: TextOverflow.visible,
              softWrap: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff8E8EA9),
              ),
            ),
          )
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
                width: 1,
              )
      ],
    );
  }
}
