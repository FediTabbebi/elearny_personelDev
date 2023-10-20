import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveHelper {
  static void handleResponsive(
      BuildContext context, DeviceScreenType deviceScreenType) {
    if (deviceScreenType == DeviceScreenType.desktop) {
      Provider.of<DeviceTypeProvider>(context, listen: false).setDeviceType(1);
    }

    if (deviceScreenType == DeviceScreenType.tablet) {
      Provider.of<DeviceTypeProvider>(context, listen: false).setDeviceType(2);
    }

    if (deviceScreenType == DeviceScreenType.mobile) {
      Provider.of<DeviceTypeProvider>(context, listen: false).setDeviceType(3);
    }
  }
}
