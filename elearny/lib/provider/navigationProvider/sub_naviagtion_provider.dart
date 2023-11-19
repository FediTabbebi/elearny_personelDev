import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubNavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

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
      initialLocation: index == navigationShell.currentIndex,
    );
    updateSelectedIndex(index);
  }
}
