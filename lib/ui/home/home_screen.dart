import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs =[];

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: Navigate to create event screen
        },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          //TODO:Search on the packages of bottomNaviagtionBar (animated bottom navigation)
          //TODO:icons_plus package
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            buildBottomNavigationBarItem(
              index: 0,
              selectedIconName: AppAssets.homeChoiceIcon,
              unSelectedIconName: AppAssets.homeIcon,
              label: AppLocalizations.of(context)!.home,
            ),
            buildBottomNavigationBarItem(
              index: 1,
              selectedIconName: AppAssets.mapChoiceIcon,
              unSelectedIconName: AppAssets.mapIcon,
              label: AppLocalizations.of(context)!.map,
            ),
            buildBottomNavigationBarItem(
              index: 2,
              selectedIconName: AppAssets.loveChoiceIcon,
              unSelectedIconName: AppAssets.loveIcon,
              label: AppLocalizations.of(context)!.love,
            ),
            buildBottomNavigationBarItem(
              index: 3,
              selectedIconName: AppAssets.profileChoiceIcon,
              unSelectedIconName: AppAssets.profileIcon,
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }
}
