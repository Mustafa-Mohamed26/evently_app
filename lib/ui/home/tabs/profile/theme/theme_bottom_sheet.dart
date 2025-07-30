import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  Widget getSelectedLanguage({required String textTheme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme, style: AppStyles.bold20Primary),
        Icon(Icons.check, color: AppColors.primaryLight, size: 35),
      ],
    );
  }

  Widget getUnSelectedLanguage({required String textTheme}) {
    return Text(textTheme, style: AppStyles.bold20Black);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              //TODO: change language to dark
              themeProvider.changeTheme(ThemeMode.dark);
              setState(() {});
            },
            child: themeProvider.isDarkMode()
                ? getSelectedLanguage(
                    textTheme: AppLocalizations.of(context)!.profile_dark,
                  )
                : getUnSelectedLanguage(
                    textTheme: AppLocalizations.of(context)!.profile_dark,
                  ),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              //TODO: change language to arabic
              themeProvider.changeTheme(ThemeMode.light);
              setState(() {});
            },
            child: !(themeProvider.isDarkMode())
                ? getSelectedLanguage(
                    textTheme: AppLocalizations.of(context)!.profile_light,
                  )
                : getUnSelectedLanguage(
                    textTheme: AppLocalizations.of(context)!.profile_light,
                  ),
          ),
        ],
      ),
    );
  }
}
