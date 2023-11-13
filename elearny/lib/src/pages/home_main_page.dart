import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Container(
            width: deviceType == 1 ? 190 : 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  60.0), // Adjust the border radius as needed
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.1), // Adjust the shadow color as needed
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      60.0), // Adjust the border radius as needed
                ),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    // tileColor: Colors.green,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(
                    //       60.0), // Adjust the border radius as needed
                    // ),
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            Theme.of(context).textTheme.headlineMedium!.color,
                        backgroundImage: CachedNetworkImageProvider(
                          globalUser!.profilePicture == ""
                              ? "assets/images/manPlaceHolder.png"
                              : globalUser!.profilePicture,
                        )), // Replace with your image URL

                    trailing: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            showMenu(
                              color:
                                  Theme.of(context).textTheme.labelSmall!.color,
                              context: context,
                              position:
                                  const RelativeRect.fromLTRB(1, 75, 0, 0),
                              items: [
                                const PopupMenuItem(
                                  child: Text('Account Settings'),
                                ),
                                const PopupMenuItem(
                                  child: Text('Profile'),
                                ),
                                const PopupMenuItem(
                                  child: Text('Logout'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    title: deviceType == 1
                        ? Text(
                            "Hi ${globalUser!.firstName}${globalUser!.lastName}",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 14),
                          )
                        : null))),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("HomeScreen"),
        ElevatedButton(
            onPressed: () {
              // context.watch<NavigationProvider>().isClosedSideMenu
              //     ? context.read<NavigationProvider>().openSideMenu()
              //     : context.read<NavigationProvider>().closeSideMenu();
            },
            child: Text(context.watch<NavigationProvider>().isClosedSideMenu
                ? "Open Side Menu"
                : "Close Side Menu"))
      ])),
    );
  }
}
