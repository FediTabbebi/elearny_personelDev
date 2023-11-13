import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/navigationProvider/main_navigation_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/globales.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: deviceType != 1
            ? deviceType == 2
                ? appBarWidget(context)
                : appBarWidget(context)
            : Center(
                child: Text(
                'Settings',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
                'Selected index: ${context.read<NavigationProvider>().selectedIndex}'),
          ),
          Center(child: Text("Welcome" "${globalUser!.firstName}")),
          Center(child: Text("Welcome" "${globalUser!.email}")),
          Center(
              child: Text("Device Type :  "
                  "${deviceType != 1 ? deviceType == 2 ? "Tablet" : "Mobile" : "Desktop"}")),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<LoginProvider>().signOutUser(context);
                },
                child: const Text("Sign out")),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ThemeProvider>().toggleTheme();
        },
        tooltip: 'switch mode',
        child: Icon(context.read<ThemeProvider>().isDarkMode
            ? Icons.dark_mode
            : Icons.light_mode),
      ),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        Navigator.pop(context);
      },
      rightIcon: null,
      title: "Settings",
      subtitle: "Here you can modify your settings ",
    );
  }
}
