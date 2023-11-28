import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/themes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: AppBarUtils.appBarWidget(context, "Settings",
              "here your can edit and adjust your settings")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            context.read<UserProvider>().currentUser!.profilePicture.isEmpty
                ? CircleAvatar(
                    // radius: deviceType == 1 ? 75 : 50,
                    radius: 100,
                    backgroundColor: context.read<ThemeProvider>().isDarkMode
                        ? Themes.darkMode
                        : Colors.grey.shade200,
                    backgroundImage:
                        const AssetImage("assets/images/manPlaceHolder.png"))
                : CircleAvatar(
                    // radius: deviceType == 1 ? 75 : 50,
                    radius: 75,
                    backgroundColor: context.read<ThemeProvider>().isDarkMode
                        ? Themes.darkMode
                        : Colors.grey.shade200,
                    backgroundImage: CachedNetworkImageProvider(
                      context.read<UserProvider>().currentUser!.profilePicture,
                    )),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${context.read<UserProvider>().currentUser!.firstName}"
                " "
                "${context.read<UserProvider>().currentUser!.lastName}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            listitleItems(context, 0, "Profile", FontAwesomeIcons.userLarge),
            listitleItems(
                context, 1, "Account security", FontAwesomeIcons.lock),
            listitleItems(context, 2, "Subscription", FontAwesomeIcons.wallet),
            listitleItems(
                context, 3, "Payment methods", FontAwesomeIcons.creditCard),
            listitleItems(
                context, 4, "Notifications", FontAwesomeIcons.solidBell),
            listitleItems(context, 5, "Privacy", FontAwesomeIcons.userLock)
          ],
        ),
      ),
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
            navigate(context, index);
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
        context.go("/Settings/Profile");
        break;
      case 1:
        context.go("/Settings/AccountSecurity");
        break;
      case 2:
        context.go("/Settings/Subscriptions");
        break;
      case 3:
        context.go("/Settings/PaymentMethod");
        break;
      case 4:
        context.go("/Settings/Notification");
        break;
      case 5:
        context.go("/Settings/Privacy&Security");
        break;
      default:
        // Handle default case or leave empty if not needed
        break;
    }
  }
}
