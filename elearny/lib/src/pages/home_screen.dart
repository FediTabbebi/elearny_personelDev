import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/navigationProvider/navigation_provider.dart';
import 'package:elearny/src/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeScreen({super.key, required this.navigationShell});

  /// The navigation shell and container for the branch Navigators.
  ///

  // final List<Widget> screens = [
  //   ProfileScreen(),
  //   const LogoutScreen(),
  //   LessonEditor(),
  //   AdminAddLinks()
  // ];

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserModel>(context, listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: deviceType == 1
            ? null
            : DrawerWidget(
                navigationShell: navigationShell,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: deviceType == 1
            ? null
            : navigationShell.currentIndex == 0
                ? Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: ElevatedButton(
                        key: UniqueKey(),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          backgroundColor:
                              Theme.of(context).textTheme.titleSmall!.color,
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          size: deviceType != 1
                              ? deviceType == 2
                                  ? 35
                                  : 30
                              : 40,
                        ),
                      ),
                    );
                  })
                : null,
        body: deviceType == 1
            ? Row(
                children: [
                  SizedBox(
                    width: deviceType != 1
                        ? deviceType == 2
                            ? 0
                            : 0
                        : 200,
                    child: NavigationRail(
                      selectedIndex: navigationShell.currentIndex,
                      onDestinationSelected: (int index) {
                        context
                            .read<NavigationProvider>()
                            .goToBranch(index, navigationShell);
                        // context
                        //     .read<NavigationProvider>()
                        //     .goToBranch(index, navigationShell);
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home_rounded),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_3_outlined),
                          selectedIcon: Icon(Icons.person_3_rounded),
                          label: Text('User Profile'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.html),
                          selectedIcon: Icon(Icons.html_rounded),
                          label: Text('Html Editor'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings_outlined),
                          selectedIcon: Icon(Icons.settings_rounded),
                          label: Text('Settings'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.link),
                          selectedIcon: Icon(Icons.link_rounded),
                          label: Text('Add links'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.people_outline),
                          selectedIcon: Icon(Icons.people_rounded),
                          label: Text('All users'),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  // Add your content widgets here based on the selected index
                  Expanded(child: navigationShell),
                ],
              )
            : Container(child: navigationShell));
  }
}
