import 'package:elearny/data/globales.dart';
import 'package:flutter/material.dart';

class DeviceTypeProvider with ChangeNotifier {
  void setDeviceType(int type) {
    deviceType = type;
  }
}
