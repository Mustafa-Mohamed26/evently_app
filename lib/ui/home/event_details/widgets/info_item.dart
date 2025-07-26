import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  IconData icon;
  String title;
  String? subTitle;
  bool subTitleVisible = true;
  InfoItem({super.key, required this.icon, required this.title, this.subTitle, this.subTitleVisible = true});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
              Text(
                title, 
                style: AppStyles.medium16Primary,
              ),
              if (subTitleVisible)
                Text(
                  subTitle ?? "",
                  style: AppStyles.medium16Black,
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
