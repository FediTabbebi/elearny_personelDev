import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  SideMenuController sideMenucontroller = SideMenuController();

  bool isClosedSideMenu = false;
  initIndex(StatefulNavigationShell navigationShell) {
    _selectedIndex = navigationShell.currentIndex;
  }

  void updateSideMenuState(bool isOpened) {
    isClosedSideMenu = isOpened;
    notifyListeners();
  }

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
