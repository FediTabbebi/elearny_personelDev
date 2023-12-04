import 'package:elearny/core/providers/deviceTypeProvider/device_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveHelper {
  static void handleResponsive(
      BuildContext context, DeviceScreenType deviceScreenType) {
    if (deviceScreenType == DeviceScreenType.desktop) {
      context.read<DeviceTypeProvider>().setDeviceType(1);
    }

    if (deviceScreenType == DeviceScreenType.tablet) {
      context.read<DeviceTypeProvider>().setDeviceType(2);
    }

    if (deviceScreenType == DeviceScreenType.mobile) {
      context.read<DeviceTypeProvider>().setDeviceType(3);
    }
  }
}
