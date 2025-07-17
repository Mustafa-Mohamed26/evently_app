import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoveTab extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: CustomTextField(
              controller: searchController,
              colorBorderSide: AppColors.primaryLight,
              cursorColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.love_search,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryLight,
                size: 35,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: height * 0.02),
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
