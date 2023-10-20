import 'package:elearny/provider/authProviders/register_provider.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/provider/splash_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => DeviceTypeProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: child,
    );
  }
}
