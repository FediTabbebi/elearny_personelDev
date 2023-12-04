import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/core/providers/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/core/providers/navigationProvider/sub_naviagtion_provider.dart';
import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/providers/userProvider/user_provider.dart';
import 'package:elearny/ui/theme/themes.dart';
import 'package:elearny/ui/widgets/shared_widget/loading_indicator_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const SettingPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? Row(
              children: [
                SideMenu(
                  backgroundColor: context.read<ThemeProvider>().isDarkMode
                      ? const Color(0xff040404)
                      : const Color(0xffF7F7F7),
                  minWidth: 200,
                  maxWidth: 300,
                  controller:
                      context.read<NavigationProvider>().sideMenucontroller,
                  mode: SideMenuMode.auto,
                  hasResizer: false,
                  hasResizerToggle: false,
                  builder: (data) {
                    return SideMenuData(
                      header: Column(
                        children: [
                          context.read<NavigationProvider>().isClosedSideMenu
                              ? const SizedBox(
                                  height: 0,
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          context
                                  .read<UserProvider>()
                                  .currentUser!
                                  .profilePicture
                                  .isEmpty
                              ? Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/manPlaceHolder.png",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: context
                                          .read<UserProvider>()
                                          .currentUser!
                                          .profilePicture
                                          .isEmpty
                                      ? "assets/images/manPlaceHolder.png"
                                      : context
                                          .read<UserProvider>()
                                          .currentUser!
                                          .profilePicture,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const LoadingIndicatorWidget(
                                          color: Themes.green, size: 50),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                          // SizedBox(
                          //   height: 150,
                          //   child: CircleAvatar(
                          //       // radius: deviceType == 1 ? 75 : 50,
                          //       radius: 70,
                          //       backgroundColor:
                          //           context.read<ThemeProvider>().isDarkMode
                          //               ? Themes.darkMode
                          //               : Colors.grey.shade200,
                          //       backgroundImage: context
                          //               .watch<UserProvider>()
                          //               .currentUser!
                          //               .profilePicture
                          //               .isEmpty
                          //           ? const AssetImage(
                          //               "assets/images/manPlaceHolder.png")
                          //           : CachedNetworkImageProvider(
                          //               context
                          //                   .read<UserProvider>()
                          //                   .currentUser!
                          //                   .profilePicture,
                          //             ) as ImageProvider<Object>?),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${context.watch<UserProvider>().currentUser!.firstName}"
                            " "
                            "${context.watch<UserProvider>().currentUser!.lastName}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
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
                ),
                Expanded(child: navigationShell)
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 150,
                    child: context
                            .read<UserProvider>()
                            .currentUser!
                            .profilePicture
                            .isEmpty
                        ? CircleAvatar(
                            // radius: deviceType == 1 ? 75 : 50,
                            radius: 100,
                            backgroundColor:
                                context.read<ThemeProvider>().isDarkMode
                                    ? Themes.darkMode
                                    : Colors.grey.shade200,
                            backgroundImage: const AssetImage(
                                "assets/images/manPlaceHolder.png"))
                        : CircleAvatar(
                            // radius: deviceType == 1 ? 75 : 50,
                            radius: 70,
                            backgroundColor:
                                context.read<ThemeProvider>().isDarkMode
                                    ? Themes.darkMode
                                    : Colors.grey.shade200,
                            backgroundImage: CachedNetworkImageProvider(
                              context
                                  .read<UserProvider>()
                                  .currentUser!
                                  .profilePicture,
                            )),
                  ),
                  Center(
                    child: Text(
                        "${context.watch<UserProvider>().currentUser!.firstName}"
                        " "
                        "${context.watch<UserProvider>().currentUser!.lastName}"),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  listitleItems(
                      context, 0, "Profile", FontAwesomeIcons.userLarge),
                  listitleItems(
                      context, 1, "Account security", FontAwesomeIcons.lock),
                  listitleItems(
                      context, 2, "Subscription", FontAwesomeIcons.wallet),
                  listitleItems(context, 3, "Payment methods",
                      FontAwesomeIcons.creditCard),
                  listitleItems(
                      context, 4, "Notifications", FontAwesomeIcons.solidBell),
                  listitleItems(
                      context, 5, "Privacy", FontAwesomeIcons.userLock)
                ],
              ),
            ),
    );
  }

  SideMenuItemDataTile sideMenuItemDatatile(
    BuildContext context,
    int branch,
    String title,
  ) {
    return SideMenuItemDataTile(
      itemHeight: 40,
      isSelected: navigationShell.currentIndex == branch,
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

  Widget listitleItems(
    BuildContext context,
    int index,
    String title,
    IconData? icon,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListTile(
          tileColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: () {
            context
                .read<SubNavigationProvider>()
                .goToBranch(index, navigationShell);
            //  navigate(context, index);
          },
          leading: Icon(
            icon,
            size: 20,
            color: Themes.grey,
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(
            FontAwesomeIcons.chevronRight,
            color: Themes.grey,
            size: 20,
          ),
        ));
  }

  void navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.push("/Settings/Profile");
        break;
      case 1:
        context.push("/Settings/AccountSecurity");
        break;
      case 2:
        context.push("/Settings/Subscriptions");
        break;
      case 3:
        context.push("/Settings/PaymentMethod");
        break;
      case 4:
        context.push("/Settings/Notification");
        break;
      case 5:
        context.push("/Settings/Privacy&Security");
        break;
      default:
        break;
    }
  }
}
