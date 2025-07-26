import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

typedef OnPressed = void Function();
class EventItem extends StatelessWidget {
  Event event;
  OnPressed onPressed;
  EventItem({super.key, required this.event, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        height: height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 2),
          image: DecorationImage(
            image: AssetImage(event.eventImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.002,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Text(
                    event.eventDataTime.day.toString(),
                    style: AppStyles.bold20Primary,
                  ),
                  Text(
                    DateFormat('MMM').format(event.eventDataTime),
                    style: AppStyles.bold14Primary,
                  ),
                ],
              ),
            ),
      
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.001,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(event.title, style: AppStyles.bold14Black),
                  ),
                  IconButton(
                    onPressed: () {
                      eventListProvider.updateIsFavorite(event, userProvider.currentUser!.id);
                    },
                    icon: event.isFavorite == true ?
                     Icon(
                      Icons.favorite,
                      color: AppColors.primaryLight,
                    ):
                     Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
