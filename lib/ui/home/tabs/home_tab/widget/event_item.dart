import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          image: AssetImage(AppAssets.birthdayImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
            padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.002),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              children: [
                Text("21", style: AppStyles.bold20Primary,),
                Text("Nov", style: AppStyles.bold14Primary,),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
            padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.001),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("This is a Birthday Party", style: AppStyles.bold14Black,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined, color: AppColors.primaryLight,),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
