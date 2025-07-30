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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventsNameList(context);
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
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
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.wb_sunny_outlined,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Text("EN", style: AppStyles.bold14Primary),
                ),
              ],
            ),
          ],
        ),
        bottom: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: height * 0.1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),
          title: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.whiteColor),
                  SizedBox(width: width * 0.02),
                  Text('Cairo, Egypt', style: AppStyles.bold14White),
                ],
              ),
              SizedBox(height: height * 0.01),
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
                  tabs: eventListProvider.eventsNameList.map((eventName) {
                    return EventTabItem(
                      unSelectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineSmall,
                      selectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineMedium,

                      selectedBgColor: Theme.of(context).focusColor,
                      isSelected:
                          eventListProvider.selectedIndex ==
                          eventListProvider.eventsNameList.indexOf(eventName),
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
                ? Center(
                    child: Text(
                      "No events found",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
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
