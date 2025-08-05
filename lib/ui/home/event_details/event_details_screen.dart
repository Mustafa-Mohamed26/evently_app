import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/event_details/widgets/info_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the EventListProvider to manage events and the AppThemeProvider for theme management
    var eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    // Retrieve the arguments passed to this screen
    // which includes the event and userId
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Event event = args['event'];
    final String userId = args['userId'];

    // Get the width and height of the screen for responsive design
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Set the app bar with a title and action buttons
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.event_details, style: AppStyles.bold20primary),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editEventRouteName,
                arguments: {'event': event, 'userId': userId},
              );
            },
            icon: Icon(
              Icons.edit_square,
              color: AppColors.primaryLight,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseUtils.deleteEventFromFirestore(userId, event.id);
              eventListProvider.getAllEvents(userId);
              ToastUtils.toastMsg(
                msg: AppLocalizations.of(context)!.event_delete,
                backGroundColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
              );
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete, color: AppColors.redColor, size: 30),
          ),
        ],
      ),

      // Set the body of the screen with a scrollable view
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              // Display the event image
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(event.eventImage),
              ),
              SizedBox(height: height * 0.01),

              // Display the event title and details
              Text(event.title, style: AppStyles.regular24primary),
              SizedBox(height: height * 0.01),

              // Display the event date and time
              InfoItem(
                icon: Icons.calendar_month,
                title:
                    '${event.eventDataTime.day} ${DateFormat.MMMM().format(event.eventDataTime)} ${event.eventDataTime.year}',
                subTitle: DateFormat.jm().format(event.eventDataTime),
              ),
              SizedBox(height: height * 0.02),
              InfoItem(
                subTitleVisible: false,
                icon: Icons.my_location,
                title: 'Cairo, Egypt',
              ),
              SizedBox(height: height * 0.02),

              // Display the event location on a map
              Image.asset(AppAssets.map, width: width),
              SizedBox(height: height * 0.01),

              // Display the event description
              Text(AppLocalizations.of(context)!.description, style: AppStyles.bold20primary),
              SizedBox(height: height * 0.01),
              Text(
                event.description,
                style: themeProvider.isDarkMode()
                    ? AppStyles.regular16White
                    : AppStyles.regular16Black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
