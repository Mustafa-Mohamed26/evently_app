import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Widget getSelectedLanguage({required String textLanguage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLanguage,
          style: AppStyles.bold20Primary,
        ),
        Icon(Icons.check, color: AppColors.primaryLight, size: 35),
      ],
    );
  }

  Widget getUnSelectedLanguage({required String textLanguage}) {
    return Text(
      textLanguage,
      style: AppStyles.bold20Black,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
              //TODO: change language to english
              languageProvider.changeLanguage('en');
              setState(() {});
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedLanguage(textLanguage: AppLocalizations.of(context)!.profile_english)
                : getUnSelectedLanguage(textLanguage: AppLocalizations.of(context)!.profile_english),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              //TODO: change language to arabic
              languageProvider.changeLanguage('ar');
              setState(() {});
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedLanguage(textLanguage: AppLocalizations.of(context)!.profile_arabic)
                : getUnSelectedLanguage(textLanguage: AppLocalizations.of(context)!.profile_arabic),
          ),
        ],
      ),
    );
  }
}
