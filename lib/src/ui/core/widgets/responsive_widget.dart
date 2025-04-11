import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  static DeviceType getDeviceType(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  @override
  Widget build(BuildContext context) {
    if (getDeviceType(context) == DeviceType.phone) {
      return mobile;
    } else {
      return tablet;
    }
  }
}
