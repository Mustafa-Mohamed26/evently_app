import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? backgroundColor;
  Color? borderColorSide;
  bool hasIcon;
  Widget? iconWidget;
  TextStyle? textStyle;
  MainAxisAlignment? mainAxisAlignment;
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.borderColorSide,
    this.hasIcon = false,
    this.iconWidget,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryLight,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 2,
            color: borderColorSide ?? AppColors.transparentColor,
          ),
        ),
      ),
      onPressed: onPressed,

      child: hasIcon
          ? Row(
            mainAxisAlignment: mainAxisAlignment!,
              children: [
                iconWidget!,
                SizedBox(width: width * 0.02),
                Text(text, style: textStyle),
              ],
            )
          : Text(text, style: AppStyles.medium20White),
    );
  }
}
