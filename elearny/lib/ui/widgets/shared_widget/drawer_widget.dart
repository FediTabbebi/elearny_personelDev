import 'package:elearny/core/providers/auth_providers/login_provider.dart';
import 'package:elearny/core/providers/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/constants/assets.dart';
import 'package:elearny/ui/widgets/shared_widget/theme_mode_switcher_widget.dart';
import 'package:elearny/ui/widgets/shared_widget/two_buttons_dialog_widget.dart';
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
                            ? Assets.splashImageDarkMode
                            : Assets.splashImageLightMode)),
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
                        inkwellWidget("Edit social links",
                            FontAwesomeIcons.link, () {}, 3, context),
                        inkwellWidget("All users", FontAwesomeIcons.peopleGroup,
                            () {}, 4, context),
                        customInkwellWidget("Quiz", () {}, 5, context),
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
                  await showDialog<void>(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return TwoButtonsDialogWidget(
                          title: 'Logout Confirmation',
                          contents: "Are you sure you want to logout?",
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

  Widget customInkwellWidget(
      String text, VoidCallback onPressed, indexRouting, BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        indexRouting < 6
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
              ImageIcon(
                AssetImage(context.read<ThemeProvider>().isDarkMode
                    ? Assets.quizIconDarkMode
                    : Assets.quizIconLightMode),
                size: 25,
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
