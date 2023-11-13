import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/src/pages/adminAddLinks/admin_add_links.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  SettingPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     toolbarHeight: 100,
        //     title: kIsWeb
        //         ? Center(
        //             child: Text(
        //             'Profile',
        //             style: Theme.of(context).textTheme.bodyLarge,
        //           ))
        //         : appBarWidget(context)),
        body: kIsWeb
            ? Row(
                children: [
                  Consumer<ThemeProvider>(
                    builder: (context, myType, child) {
                      return SideMenu(
                        backgroundColor: myType.isDarkMode
                            ? const Color(0xff040404)
                            : const Color(0xffF7F7F7),
                        minWidth: 200,
                        maxWidth: 300,
                        controller: context
                            .read<NavigationProvider>()
                            .sideMenucontroller,
                        mode: SideMenuMode.auto,
                        hasResizer: false,
                        hasResizerToggle: false,
                        builder: (data) {
                          return SideMenuData(
                            header: Column(
                              children: [
                                context
                                        .read<NavigationProvider>()
                                        .isClosedSideMenu
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : const SizedBox(
                                        height: 20,
                                      ),
                                SizedBox(
                                  height: 150,
                                  child: CircleAvatar(
                                      // radius: deviceType == 1 ? 75 : 50,
                                      radius: 70,
                                      backgroundColor: context
                                              .read<ThemeProvider>()
                                              .isDarkMode
                                          ? Themes.darkMode
                                          : Colors.grey.shade200,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        globalUser!.profilePicture == ""
                                            ? "assets/images/manPlaceHolder.png"
                                            : globalUser!.profilePicture,
                                      )),
                                ),
                                Text("${globalUser!.firstName}"
                                    " "
                                    "${globalUser!.lastName}"),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            items: [
                              sideMenuItemDatatile(
                                context,
                                0,
                                "Profile",
                              ),
                              sideMenuItemDatatile(
                                context,
                                1,
                                "Account security",
                              ),
                              sideMenuItemDatatile(
                                context,
                                2,
                                "Subscription",
                              ),
                              sideMenuItemDatatile(
                                context,
                                3,
                                "Payment methods",
                              ),
                              sideMenuItemDatatile(
                                context,
                                4,
                                "Notifications",
                              ),
                              sideMenuItemDatatile(
                                context,
                                5,
                                "Privacy",
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Expanded(child: navigationShell)
                ],
              )
            : Container(child: navigationShell));
  }

  SideMenuItemDataTile sideMenuItemDatatile(
    BuildContext context,
    int branch,
    String title,
  ) {
    return SideMenuItemDataTile(
      itemHeight: 40,
      isSelected: context.read<SubNavigationProvider>().selectedIndex == branch,
      onTap: () {
        context
            .read<SubNavigationProvider>()
            .goToBranch(branch, navigationShell);
      },
      title: title,
      titleStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: 18,
          fontWeight: FontWeight.w200),
      selectedTitleStyle: const TextStyle(color: Themes.white),
      highlightSelectedColor: Themes.green,
    );
  }
}
