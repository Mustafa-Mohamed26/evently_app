import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Text(AppLocalizations.of(context)!.language),
        leading:Icon(Icons.arrow_back_ios),
      ),
      body: ProfileTab(),
    );
  }
}