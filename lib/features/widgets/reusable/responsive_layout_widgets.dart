import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? smallTablet;
  final Widget? largeTablet;
  final Widget? smallDesktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.smallTablet,
    this.largeTablet,
    this.smallDesktop,
    this.largeDesktop,
  });

  static double _width(BuildContext context) => MediaQuery.of(context).size.width;

  static bool isMobile(BuildContext context) => _width(context) < 600;

  static bool isSmallTablet(BuildContext context) =>
      _width(context) >= 600 && _width(context) < 800;

  static bool isLargeTablet(BuildContext context) =>
      _width(context) >= 800 && _width(context) < 1024;

  static bool isSmallDesktop(BuildContext context) =>
      _width(context) >= 1024 && _width(context) < 1440;

  static bool isLargeDesktop(BuildContext context) => _width(context) >= 1440;

  @override
  Widget build(BuildContext context) {
    final width = _width(context);
    if (kDebugMode) debugPrint("📱 Screen width: $width");

    if (width >= 1440 && largeDesktop != null) {
      return largeDesktop!;
    } else if (width >= 1024 && smallDesktop != null) {
      return smallDesktop!;
    } else if (width >= 800 && largeTablet != null) {
      return largeTablet!;
    } else if (width >= 600 && smallTablet != null) {
      return smallTablet!;
    } else {
      return mobile;
    }
  }
}
