import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:evently_app/utils/app_colors.dart';

typedef ValueChanged<T> = void Function(T value);

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final Widget activeIcon;
  final Widget inactiveIcon;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;
  final double toggleSize;
  final double borderRadius;
  final double padding;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    required this.activeIcon,
    required this.inactiveIcon,
    this.activeColor = AppColors.primaryLight,
    this.inactiveColor = AppColors.primaryLight,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleSize = 30.0,
    this.borderRadius = 30.0,
    this.padding = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: width,
      height: height,
      toggleSize: toggleSize,
      value: value,
      borderRadius: borderRadius,
      padding: padding,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      activeIcon: activeIcon,
      inactiveIcon: inactiveIcon,
      onToggle: onToggle,
    );
  }
}
