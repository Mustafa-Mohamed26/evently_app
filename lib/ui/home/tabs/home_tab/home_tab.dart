import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    // Get the width and height of the screen to use for responsive design
    // This allows the UI to adapt to different screen sizes.
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Access the providers to get the necessary data and methods
    // These providers manage the app's language, theme, events, and user data.
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    bool isLightTheme = themeProvider.appTheme == ThemeMode.light;
    bool isEnglish = languageProvider.appLanguage == 'en';

    eventListProvider.getEventsNameList(context); // Get the events name list
    eventListProvider.getEventLocalizationsNameList(context); // Get localized event names

    // If the event list is empty, fetch all events for the current user
    // This ensures that the UI displays the latest events available.
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    return Scaffold(
      appBar: AppBar(
        // the design of the app bar is based on the current theme
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),

        title: Row(
          children: [
            // The app bar title includes the user's name and a welcome message.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.home_welcome,
                  style: AppStyles.regular14white,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White,
                ),
              ],
            ),

            Spacer(),

            // The app bar includes a button to change the theme and language.
            // It uses the current theme and language to determine the icons and text.
            Row(
              children: [
                // The app bar includes a button to change the theme.
                IconButton(
                  onPressed: () {
                    if (isLightTheme) {
                      themeProvider.changeTheme(ThemeMode.dark);
                    } else {
                      themeProvider.changeTheme(ThemeMode.light);
                    }
                  },
                  icon: Icon(
                    isLightTheme
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_rounded,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                ),

                // The app bar includes a button to change the language.
                InkWell(
                  onTap: () {
                    if (isEnglish) {
                      languageProvider.changeLanguage('ar');
                    } else {
                      languageProvider.changeLanguage('en');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: width * 0.02),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.whiteColor,
                    ),
                    child: Text(
                      isEnglish ? "EN" : "AR",
                      style: AppStyles.bold14Primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // The app bar includes a bottom tab bar for selecting event categories.
        // It allows users to filter events based on their preferences.
        bottom: AppBar(
          // The bottom tab bar has a custom design based on the current theme.
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: height * 0.1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),

          // The app bar title includes the location and a tab bar for event categories.
          // The location is displayed with an icon and text.
          title: Column(
            children: [
              // The location is displayed with an icon and text.
              // It shows the current location of the user.
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.whiteColor),
                  SizedBox(width: width * 0.02),
                  Text('Cairo, Egypt', style: AppStyles.bold14White),
                ],
              ),

              SizedBox(height: height * 0.01),
              // The tab bar allows users to select different event categories.
              // It displays the names of the event categories as tabs.
              DefaultTabController(
                length: eventListProvider.eventsNameList.length,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(
                      index,
                      userProvider.currentUser!.id,
                    );
                    setState(() {});
                  },
                  tabs: eventListProvider.eventsNameListLocalizations.map((eventName) {
                    return EventTabItem(
                      icon:
                          AppResources.iconsList[eventListProvider
                              .eventsNameListLocalizations
                              .indexOf(eventName)],
                      iconColor: isLightTheme
                          ? AppColors.primaryLight
                          : AppColors.whiteColor,
                      unSelectedIconColor: AppColors.whiteColor,
                      unSelectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineSmall,
                      selectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineMedium,

                      selectedBgColor: Theme.of(context).focusColor,
                      isSelected:
                          eventListProvider.selectedIndex ==
                          eventListProvider.eventsNameList.indexOf(eventName) ||
                          eventListProvider.selectedIndex ==
                          eventListProvider.eventsNameListLocalizations.indexOf(eventName),
                          
                      eventName: eventName,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: eventListProvider.filteredEventList.isEmpty
                // If there are no events in the filtered list, display a message
                // indicating that no events were found.
                ? Center(
                    child: Text(
                      "No events found",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                // If there are events in the filtered list, display them in a list view.
                : ListView.separated(
                    padding: EdgeInsets.only(top: height * 0.02),
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: eventListProvider.filteredEventList[index],
                        onPressed: () {
                          // Navigate to event details or perform any action
                          Navigator.of(context).pushNamed(
                            AppRoutes.eventDetailsRouteName,
                            arguments: {
                              'event':
                                  eventListProvider.filteredEventList[index],
                              'userId': userProvider.currentUser!.id,
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * 0.02);
                    },
                    itemCount: eventListProvider.filteredEventList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
