import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  List<Event> filterFavoriteEventList = [];

  @override
  void initState() {
    super.initState();
    // WidgetBinging is used to call the function after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //eventListProvider.getAllFavoriteEvent();
      eventListProvider.getAllFavoriteEventFromFireStore(
        userProvider.currentUser!.id,
      );
      // After fetching favorite events, filter them
      Future.delayed(Duration(milliseconds: 100), () {
        filterFavoriteEventList = eventListProvider.favoriteEventList;
        setState(() {});
      });
    });
  }

  void searchByText(String? text) {
    if (text == null || text.isEmpty) {
      filterFavoriteEventList = eventListProvider.favoriteEventList;
    } else {
      filterFavoriteEventList = eventListProvider.favoriteEventList.where((
        event,
      ) {
        return event.eventName.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
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
              onChanged: (text) {
                searchByText(text);
              },
            ),
          ),
          Expanded(
            child: filterFavoriteEventList.isEmpty
                ? Center(
                    child: Text(
                      "No favorite events",
                      style: AppStyles.medium16Black,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: height * 0.02),
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: filterFavoriteEventList[index],
                        onPressed: () {
                          // Navigate to event details or perform any action
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * 0.02);
                    },
                    itemCount: filterFavoriteEventList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
