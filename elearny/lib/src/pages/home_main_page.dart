import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    //  print("rebuilding");
    return LayoutBuilder(builder: (context, constraint) {
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
                      leading: context
                              .read<UserProvider>()
                              .currentUser!
                              .profilePicture
                              .isEmpty
                          ? Container(
                              height: 50,
                              width: 50,
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
                                  .profilePicture,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const UnconstrainedBox(
                                child: SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: LoadingIndicatorWidget(
                                        color: Themes.green, size: 12.5),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                      // Replace with your image URL

                      trailing: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: const Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              showMenu(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color,
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
                              "Hi ${context.read<UserProvider>().currentUser!.firstName}${context.read<UserProvider>().currentUser!.lastName}",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 14),
                            )
                          : null))),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("HomeScreen"),
          ElevatedButton(
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
              child: Text(context.watch<ThemeProvider>().isDarkMode
                  ? "DarkMode"
                  : "LightMode")),
        ])),
      );
    });
  }
}
