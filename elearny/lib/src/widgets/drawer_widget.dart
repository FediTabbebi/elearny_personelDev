import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/routes/app_pages.dart';
import 'package:elearny/src/widgets/theme_mode_switcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const DrawerWidget({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: 275,
          child: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                    child: Image.asset(
                        scale: 4,
                        context.read<ThemeProvider>().isDarkMode
                            ? "assets/images/theTeam_DarkMode.png"
                            : "assets/images/theTeam.png")),
                // DrawerHeader(
                //     decoration: BoxDecoration(
                //         color: Theme.of(context).textTheme.labelLarge!.color,
                //         border: Border(
                //           bottom: BorderSide(
                //             color:
                //                 Theme.of(context).textTheme.labelLarge!.color!,
                //             width: 0.2,
                //           ),
                //         )),
                //     child: InkWell(
                //       onTap: () {},
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //               backgroundColor: Colors.transparent,
                //               radius: deviceType != 1
                //                   ? deviceType == 2
                //                       ? 50
                //                       : 40
                //                   : 50,
                //               child: globalUser!.profilePicture != ""
                //                   ? CachedNetworkImage(
                //                       fadeInDuration:
                //                           const Duration(milliseconds: 150),
                //                       imageUrl: globalUser!.profilePicture,
                //                       // placeholder: (context, url) =>
                //                       //     progressIndicator(),
                //                       errorWidget: (context, url, error) =>
                //                           const Icon(Icons.error),
                //                     )
                //                   : Image.asset(
                //                       'assets/images/PlaceholderImg.png',
                //                     )),
                //           deviceType != 1
                //               ? deviceType == 2
                //                   ? const SizedBox(width: 35)
                //                   : const SizedBox(width: 10)
                //               : const SizedBox(width: 10),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 width: deviceType != 1
                //                     ? deviceType == 2
                //                         ? 250
                //                         : 150
                //                     : 300,
                //                 child: Text(
                //                   overflow: TextOverflow.ellipsis,
                //                   globalUser!.firstName,
                //                   style: TextStyle(
                //                     color: Theme.of(context)
                //                         .textTheme
                //                         .bodyMedium!
                //                         .color,
                //                     // fontWeight: FontWeight.bold,
                //                     fontSize: deviceType != 1
                //                         ? deviceType == 2
                //                             ? 18
                //                             : 16
                //                         : 25,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: deviceType != 1
                //                     ? deviceType == 2
                //                         ? 250
                //                         : 150
                //                     : 300,
                //                 child: Text(
                //                   softWrap: true,
                //                   overflow: TextOverflow.ellipsis,
                //                   globalUser!.email,
                //                   style: TextStyle(
                //                     color: const Color(0xff8E8EA9),
                //                     fontWeight: FontWeight.w300,
                //                     fontSize: deviceType != 1
                //                         ? deviceType == 2
                //                             ? 18
                //                             : 14
                //                         : 17,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     )),
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        inkwellWidget(
                            "Home", FontAwesomeIcons.house, () {}, 0, context),
                        inkwellWidget("Html Editor", FontAwesomeIcons.code,
                            () {}, 1, context),
                        inkwellWidget("Settings", FontAwesomeIcons.gear, () {},
                            2, context),
                        inkwellWidget("Add links", FontAwesomeIcons.link, () {},
                            3, context),
                        inkwellWidget("All users", FontAwesomeIcons.peopleGroup,
                            () {}, 4, context),
                      ],
                    ),
                  ),
                ),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: ThemeModeSwitcherWidget()),
                const SizedBox(height: 20),
                inkwellWidget("Logout", FontAwesomeIcons.arrowRightFromBracket,
                    () async {
                  await context.read<LoginProvider>().signOutUser(context);
                  AppNavigation.router.refresh();
                }, 7, context),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }

  Widget inkwellWidget(String text, IconData icon, VoidCallback onPressed,
      indexRouting, BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        indexRouting < 5
            ? context
                .read<NavigationProvider>()
                .goToBranch(indexRouting, navigationShell)
            : null;
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
