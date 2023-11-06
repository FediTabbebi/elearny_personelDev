import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/navigationProvider/navigation_provider.dart';
import 'package:flutter/material.dart';
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
          width: deviceType != 1
              ? deviceType == 2
                  ? 450
                  : 300
              : 500,
          child: Drawer(
            backgroundColor: Theme.of(context).textTheme.titleSmall!.color,
            child: Column(
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        border: Border(
                          bottom: BorderSide(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color!,
                            width: 0.2,
                          ),
                        )),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: deviceType != 1
                                  ? deviceType == 2
                                      ? 50
                                      : 40
                                  : 50,
                              child: globalUser!.profilePicture != ""
                                  ? CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 150),
                                      imageUrl: globalUser!.profilePicture,
                                      // placeholder: (context, url) =>
                                      //     progressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.asset(
                                      'assets/images/PlaceholderImg.png',
                                    )),
                          deviceType != 1
                              ? deviceType == 2
                                  ? const SizedBox(width: 35)
                                  : const SizedBox(width: 10)
                              : const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: deviceType != 1
                                    ? deviceType == 2
                                        ? 250
                                        : 150
                                    : 300,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  globalUser!.firstName,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: deviceType != 1
                                        ? deviceType == 2
                                            ? 18
                                            : 16
                                        : 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: deviceType != 1
                                    ? deviceType == 2
                                        ? 250
                                        : 150
                                    : 300,
                                child: Text(
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  globalUser!.email,
                                  style: TextStyle(
                                    color: const Color(0xff8E8EA9),
                                    fontWeight: FontWeight.w300,
                                    fontSize: deviceType != 1
                                        ? deviceType == 2
                                            ? 18
                                            : 14
                                        : 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      inkwellWidget(
                          "Home", Icons.home_outlined, () {}, 0, context),
                      inkwellWidget(
                          "Profile", Icons.person_outlined, () {}, 1, context),
                      inkwellWidget("Html Editor'", Icons.html_rounded, () {},
                          2, context),
                      inkwellWidget(
                          "Settings", Icons.sos_rounded, () {}, 3, context),
                      inkwellWidget("Add links", Icons.privacy_tip_outlined,
                          () {}, 4, context),
                    ],
                  ),
                ),
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
        context
            .read<NavigationProvider>()
            .goToBranch(indexRouting, navigationShell);
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: deviceType != 1
              ? deviceType == 2
                  ? 30
                  : 20
              : 20,
        ),
        child: SizedBox(
          height: deviceType != 1
              ? deviceType == 2
                  ? 90
                  : 60
              : 90,
          child: Row(
            children: [
              Icon(
                icon,
                size: deviceType != 1
                    ? deviceType == 2
                        ? 27
                        : 25
                    : 27,
              ),
              deviceType != 1
                  ? deviceType == 2
                      ? const SizedBox(
                          width: 30,
                        )
                      : const SizedBox(
                          width: 10,
                        )
                  : const SizedBox(
                      width: 20,
                    ),
              Text(
                text,
                style: TextStyle(
                  fontSize: deviceType != 1
                      ? deviceType == 2
                          ? 22
                          : 17
                      : 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
