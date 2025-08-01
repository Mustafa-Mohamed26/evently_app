import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  final bool isSelected;
  final String eventName;
  final Color selectedBgColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;
  final Color? borderColor;
  final IconData icon;
  final Color iconColor;
  final Color unSelectedIconColor;
  const EventTabItem({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.selectedBgColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.unSelectedIconColor
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.006,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderColor ?? Theme.of(context).focusColor,
          width: 2,
        ),
        color: isSelected ? selectedBgColor : AppColors.transparentColor,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? iconColor : unSelectedIconColor,
                
          ),
          SizedBox(width: width * 0.01),
          Text(
            eventName,
            style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          ),
        ],
      ),
    );
  }
}
