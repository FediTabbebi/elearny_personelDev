import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveHelper {
  static void handleResponsive(
      BuildContext context, DeviceScreenType deviceScreenType) {
    if (deviceScreenType == DeviceScreenType.desktop) {
      context.read<DeviceTypeProvider>().setDeviceType(1);
      // print("ITSSSS DEEEESKTOP");
      // print("deviceType === 1  (1 is for desktop)");
    }

    if (deviceScreenType == DeviceScreenType.tablet) {
      context.read<DeviceTypeProvider>().setDeviceType(2);
      // print("ITSSSS TABLEEEEEEEET");
      // print("deviceType === 2  (2 is for t tablet )");
    }

    if (deviceScreenType == DeviceScreenType.mobile) {
      context.read<DeviceTypeProvider>().setDeviceType(3);
      // print("ITSSSS SMATPHOOOONE");
      // print("deviceType === 3  (3 is for smartphone)");
    }
  }
}
