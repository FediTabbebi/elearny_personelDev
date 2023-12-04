 // SizedBox(
                    //   width: deviceType != 1
                    //       ? deviceType == 2
                    //           ? 0
                    //           : 0
                    //       : 100,
                    //   child: LayoutBuilder(builder: (context, constraint) {
                    //     return SingleChildScrollView(
                    //       child: ConstrainedBox(
                    //         constraints:
                    //             BoxConstraints(minHeight: constraint.maxHeight),
                    //         child: IntrinsicHeight(
                    //           child: NavigationRail(
                    //             leading: CachedNetworkImage(
                    //                 imageUrl:
                    //                     "assets/images/theTeam_DarkMode.png"),
                    //             selectedIndex: navigationShell.currentIndex,
                    //             onDestinationSelected: (int index) {
                    //               context
                    //                   .read<NavigationProvider>()
                    //                   .goToBranch(index, navigationShell);
                    //               // context
                    //               //     .read<NavigationProvider>()
                    //               //     .goToBranch(index, navigationShell);
                    //             },
                    //             labelType: NavigationRailLabelType.none,
                    //             destinations: const [
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.home_outlined),
                    //                 selectedIcon: Icon(Icons.home_rounded),
                    //                 label: Text('Home'),
                    //               ),
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.person_3_outlined),
                    //                 selectedIcon: Icon(Icons.person_3_rounded),
                    //                 label: Text('User Profile'),
                    //               ),
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.html),
                    //                 selectedIcon: Icon(Icons.html_rounded),
                    //                 label: Text('Html Editor'),
                    //               ),
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.settings_outlined),
                    //                 selectedIcon: Icon(Icons.settings_rounded),
                    //                 label: Text('Settings'),
                    //               ),
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.link),
                    //                 selectedIcon: Icon(Icons.link_rounded),
                    //                 label: Text('Add links'),
                    //               ),
                    //               NavigationRailDestination(
                    //                 icon: Icon(Icons.people_outline),
                    //                 selectedIcon: Icon(Icons.people_rounded),
                    //                 label: Text('All users'),
                    //               ),
                    //               NavigationRailDestination(
                    //                   icon: ThemeModeSwitcherWidget(),
                    //                   label: Text(''),
                    //                   indicatorColor: Colors.transparent),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   }),
                    // ),