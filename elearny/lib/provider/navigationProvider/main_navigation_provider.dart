import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  SideMenuController sideMenucontroller = SideMenuController();

  bool isClosedSideMenu = false;
  final StreamController<bool> streamController = StreamController();
  void isOpenedMenu() {
    //  sideMenucontroller.close();
    isClosedSideMenu = false;
    notifyListeners();
  }

  void isClosedSMenu() {
    // sideMenucontroller.open();
    isClosedSideMenu = true;
    notifyListeners();
  }

  void updateSideMenuState() {
    isClosedSideMenu = !isClosedSideMenu;
    notifyListeners();
  }
  // void checkSideBarState() {
  //   isClosedSideMenu = sideMenuMode == SideMenuMode.open;
  //   streamController.sink.add(isClosedSideMenu);
  //   print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  //   print(isClosedSideMenu);
  //   notifyListeners();
  // }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void goToBranch(index, StatefulNavigationShell navigationShell) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
    updateSelectedIndex(index);
  }
}
