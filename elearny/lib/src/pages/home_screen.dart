import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/drawer_widget.dart';
import 'package:elearny/src/widgets/theme_mode_switcher_widget.dart';
import 'package:elearny/src/widgets/two_buttons_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    // print("indexxxxxxxxxxx");
    // print(navigationShell.currentIndex);
    //  context.read<NavigationProvider>().initIndex(navigationShell);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          drawer: kIsWeb
              ? null
              : DrawerWidget(
                  navigationShell: navigationShell,
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: kIsWeb
              ? null
              : Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        navigationShell.currentIndex == 0
                            ? Scaffold.of(context).openDrawer()
                            : context.canPop()
                                ? context.pop()
                                : context.goNamed(AppPage.home.toName);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor:
                            Theme.of(context).textTheme.titleSmall!.color,
                      ),
                      child: Icon(
                          navigationShell.currentIndex == 0
                              ? Icons.menu
                              : Icons.chevron_left,
                          color: Themes.grey,
                          size: 30),
                    ),
                  );
                }),
          body: kIsWeb
              ? Row(
                  children: [
                    SideMenu(
                      backgroundColor: Themes.black2,
                      minWidth: 80,
                      controller:
                          context.read<NavigationProvider>().sideMenucontroller,
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
                                  height: 80,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    child: data.isOpen
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                "assets/images/theTeam_DarkMode.png")
                                        : UnconstrainedBox(
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Themes.green),
                                              child: const Icon(
                                                FontAwesomeIcons.graduationCap,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                //  Align(
                                //    alignment: Alignment.bottomRight,
                                //    child: GestureDetector(
                                //        onTap: () {
                                //          context
                                //                  .read<NavigationProvider>()
                                //                  .isClosedSideMenu
                                //              ? context
                                //                  .read<NavigationProvider>()
                                //                  .openSideMenu()
                                //              : context
                                //                  .read<NavigationProvider>()
                                //                  .closeSideMenu();
                                //        },
                                //        child: const Icon(Icons.chevron_right)),
                                //  ),
                              ],
                            ),
                            items: [
                              sideMenuItemDatatile(
                                  context, 0, "Home", FontAwesomeIcons.house),
                              // sideMenuItemDatatile(context, 1, "User Profile",
                              //     FontAwesomeIcons.user),
                              sideMenuItemDatatile(context, 1, "Html Editor",
                                  FontAwesomeIcons.code),
                              sideMenuItemDatatile(context, 2, "Settings",
                                  FontAwesomeIcons.gear),
                              sideMenuItemDatatile(context, 3, "Edit app Links",
                                  FontAwesomeIcons.link),
                              sideMenuItemDatatile(context, 4, "All users",
                                  FontAwesomeIcons.peopleGroup),
                              customSideMenuItemDatatile(
                                context,
                                5,
                                "Quiz",
                              ),
                            ],
                            footer: Column(
                              children: [
                                data.isOpen
                                    ? ThemeModeSwitcherWidget(
                                        currentWidth: data.currentWidth,
                                      )
                                    : const ThemeModeSwitcherWidgetSmall(),
                                footerWidget(
                                  data,
                                  context,
                                  () async {
                                    await showDialog<void>(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return TwoButtonsDialogWidget(
                                            title: 'Logout Confirmation',
                                            contents:
                                                "Are you sure you want to logout?",
                                            confirmbuttonText: 'Confirm',
                                            declinebuttonText: 'Back',
                                            onConfirm: () async {
                                              // Navigator.of(context).pop();
                                              await context
                                                  .read<LoginProvider>()
                                                  .signOutUser(context);
                                            },
                                            onDecline: () {
                                              context.pop();
                                            },
                                          );
                                        });
                                  },
                                  const AutoSizeText(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  true,
                                  FontAwesomeIcons.arrowRightFromBracket,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ));
                      },
                    ),
                    Expanded(child: navigationShell)
                  ],
                )
              : Container(child: navigationShell)),
    );
  }

  SideMenuItemDataTile sideMenuItemDatatile(
      BuildContext context, int branch, String title, IconData? iconData) {
    return SideMenuItemDataTile(
      itemHeight: 60,
      isSelected: navigationShell.currentIndex == branch,
      onTap: () {
        context.read<NavigationProvider>().goToBranch(branch, navigationShell);
        if (branch == 4) {}
      },
      title: title,
      icon: Icon(
        iconData,
        size: 20,
      ),
      // selectedIcon: const Icon(Icons.home),
      titleStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
      selectedTitleStyle: const TextStyle(
        color: Themes.green,
        fontSize: 18,
      ),
      highlightSelectedColor: Themes.black2,
    );
  }

  SideMenuItemDataTile customSideMenuItemDatatile(
    BuildContext context,
    int branch,
    String title,
  ) {
    return SideMenuItemDataTile(
      itemHeight: 60,
      isSelected: navigationShell.currentIndex == branch,
      onTap: () {
        context.read<NavigationProvider>().goToBranch(branch, navigationShell);
        if (branch == 5) {}
      },
      title: title,
      icon: const UnconstrainedBox(
        child: ImageIcon(
          AssetImage("assets/icons/quizIconDarkMode.png"),
          size: 30,
        ),
      ),
      // selectedIcon: const Icon(Icons.home),
      titleStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
      selectedTitleStyle: const TextStyle(
        color: Themes.green,
        fontSize: 18,
      ),
      highlightSelectedColor: Themes.black2,
    );
  }

  Widget footerWidget(dynamic data, BuildContext context,
      void Function()? onTap, Widget widget, bool withIcon, IconData iconData) {
    return Container(
      height: 60,
      margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: InkWell(
          onTap: () {
            onTap!();
          },
          // hoverColor: AppColors.onPrimaryGreen.withOpacity(0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              withIcon
                  ? SizedBox(
                      width: data.minWidth,
                      height: double.maxFinite,
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Icon(
                          iconData,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox(),
              if (data.isOpen) Expanded(child: widget),
            ],
          ),
        ),
      ),
    );
  }
}
