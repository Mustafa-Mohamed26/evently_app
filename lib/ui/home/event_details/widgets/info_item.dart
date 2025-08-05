import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoItem extends StatelessWidget {
  /// A widget that displays an icon, title, and optional subtitle.
  final IconData icon;
  final String title;
  final String? subTitle;
  final bool subTitleVisible;
  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.subTitleVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    // Access the AppThemeProvider to check the current theme
    var themeProvider = Provider.of<AppThemeProvider>(context);
    // Get the width and height of the screen for responsive design
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // Build the InfoItem widget with an icon, title, and optional subtitle
    // The widget is styled based on the current theme
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryLight,
            ),
            child: Icon(icon, color: AppColors.whiteColor),
          ),
          SizedBox(width: width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.medium16Primary),
              if (subTitleVisible)
                Text(
                  subTitle ?? "",
                  style: themeProvider.isDarkMode()
                      ? AppStyles.medium16White
                      : AppStyles.medium16Black,
                ),
            ],
          ),

          Spacer(),
          Icon(Icons.arrow_forward_ios, color: AppColors.primaryLight),
        ],
      ),
    );
  }
}
