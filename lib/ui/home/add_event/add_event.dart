import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/add_event/widgets/date_or_time_widget.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_resources.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var formKey = GlobalKey<FormState>();
  // data controllers
  TextEditingController titleController = TextEditingController(); // title
  TextEditingController descriptionController =
      TextEditingController(); // description
  DateTime? selectedDate; // selected date
  String formateDate = ''; // formatted date
  TimeOfDay? selectedTime; // selected time
  String formateTime = ''; // formatted time
  String selectedEventImage = ''; // selected event image
  String selectedEventName = ''; // selected event name
  int selectedIndex = 0; // selected index for event category
  late EventListProvider eventListProvider; // event list provider
  bool isSubmitted = false; // flag to check if the form is submitted

  @override
  Widget build(BuildContext context) {
    // List of event names and images for event category localization
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.category_sport,
      AppLocalizations.of(context)!.category_birthday,
      AppLocalizations.of(context)!.category_meeting,
      AppLocalizations.of(context)!.category_gaming,
      AppLocalizations.of(context)!.category_workshop,
      AppLocalizations.of(context)!.category_bookclub,
      AppLocalizations.of(context)!.category_exhibition,
      AppLocalizations.of(context)!.category_holiday,
      AppLocalizations.of(context)!.category_eating,
    ];

    // List of event images corresponding to the event categories
    List<String> eventsImageList = [
      AppAssets.sportImage,
      AppAssets.birthdayImage,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.workshopImage,
      AppAssets.bookClubImage,
      AppAssets.exhibitionImage,
      AppAssets.holidayImage,
      AppAssets.eatingImage,
    ];

    // List of icons corresponding to the event categories
    List iconsList = [
      Icons.all_inclusive_outlined,
      Icons.sports_soccer_outlined,
      Icons.cake_outlined,
      Icons.business_center_outlined,
      Icons.videogame_asset_outlined,
      Icons.theater_comedy_outlined,
      Icons.book_outlined,
      Icons.image_outlined,
      Icons.beach_access_outlined,
      Icons.restaurant_menu_outlined,
    ];

    // Set the selected event image and name based on the selected index
    selectedEventImage = eventsImageList[selectedIndex];
    //selectedEventName = eventsNameList[selectedIndex];
    selectedEventName = AppResources.categoriesSelectedList[selectedIndex + 1];

    // Get the height and width of the screen
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Get the theme provider and event list provider
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);

    // Function to choose date using date picker
    void chooseDate() async {
      var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      );

      selectedDate = chooseDate;
      if (selectedDate != null) {
        formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
        setState(() {});
      }
    }

    // Function to choose time using time picker
    void chooseTime() async {
      var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      selectedTime = chooseTime;
      if (selectedTime != null) {
        formateTime = selectedTime!.format(context);
        setState(() {});
      }
    }

    // Function to add the event after validation
    // It checks if the form is valid, date and time are selected, and then creates
    void addEvent() {
      isSubmitted = true;
      setState(() {});
      if (formKey.currentState!.validate() == true &&
          selectedDate != null &&
          selectedTime != null) {
        // Create an event object with the provided data
        Event event = Event(
          title: titleController.text,
          description: descriptionController.text,
          eventImage: selectedEventImage,
          eventName: selectedEventName,
          eventDataTime: selectedDate!,
          eventTime: formateDate,
        );

        // Add the event to Firestore and update the event list
        // It uses the UserProvider to get the current user ID
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        FirebaseUtils.addEventToFireStore(
              event,
              userProvider.currentUser!.id,
            ) // add event to Firestore
            .then((value) {
              ToastUtils.toastMsg(
                msg: "Event added Successfully",
                backGroundColor: AppColors.primaryLight,
                textColor: AppColors.whiteColor,
              );
              // After adding the event, fetch all events for the current user
              eventListProvider.getAllEvents(userProvider.currentUser!.id);
              Navigator.pop(context);
            })
            .catchError((error) {
              ToastUtils.toastMsg(
                msg: "Failed to add event",
                backGroundColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
              );
            });
      }
    }

    return Scaffold(
      // AppBar with a transparent background and centered title
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary,
        ),
      ),

      // Main body of the AddEvent screen
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Event image
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(eventsImageList[selectedIndex]),
              ),
              SizedBox(height: height * 0.02),

              // Horizontal list of event categories with icons
              SizedBox(
                height: height * 0.04,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: EventTabItem(
                        icon: iconsList[index],
                        iconColor: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.whiteColor
                            : AppColors.primaryDark,
                        unSelectedIconColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight,
                        unSelectedTextStyle: AppStyles.medium16Primary,
                        selectedTextStyle:
                            themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.bold16White
                            : AppStyles.bold16Black,
                        selectedBgColor: AppColors.primaryLight,
                        isSelected: selectedIndex == index,
                        eventName: eventsNameList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * 0.01);
                  },
                  itemCount: eventsNameList.length,
                ),
              ),
              SizedBox(height: height * 0.02),

              // Form to add event details
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title field
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ), 
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.title_error; 
                        }
                        return null;
                      },
                      colorBorderSide: themeProvider.isDarkMode()
                          ? AppColors.primaryLight
                          : AppColors.greyColor,

                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      controller: titleController,
                      prefixIcon: Icon(
                        Icons.note_alt_outlined,
                        color: Theme.of(context).dividerColor,
                        size: 30,
                      ),
                      hintText: AppLocalizations.of(context)!.title_input, 
                    ),

                    SizedBox(height: height * 0.02),

                    // Description field
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.titleLarge,
                    ), 
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.description_error;
                        }
                        return null;
                      },
                      colorBorderSide: themeProvider.isDarkMode()
                          ? AppColors.primaryLight
                          : AppColors.greyColor,
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      controller: descriptionController,
                      maxLines: 4,
                      hintText: AppLocalizations.of(context)!.description_input,
                    ),

                    SizedBox(height: height * 0.01),

                    // Date field
                    DateOrTimeWidget(
                      iconDateOrTime: Icons.calendar_month_outlined,
                      eventDateOrTime: AppLocalizations.of(context)!.event_date, 
                      chooseDateOrTime: selectedDate == null
                          ? AppLocalizations.of(context)!.choose_date 
                          : formateDate, //'${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}',
                      onChooseDateOrTimeClick: chooseDate,
                    ),
                    Visibility(
                      visible: selectedDate == null && isSubmitted == true,
                      child: Text(
                        AppLocalizations.of(context)!.event_date_error,
                        style: AppStyles.medium16Black.copyWith(
                          color: AppColors.redColor,
                        ),
                      ),
                    ),

                    // Time field
                    DateOrTimeWidget(
                      iconDateOrTime: Icons.timelapse_rounded,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      chooseDateOrTime: selectedTime == null
                          ? AppLocalizations.of(context)!.choose_time
                          : formateTime,
                      onChooseDateOrTimeClick: chooseTime,
                    ),
                    Visibility(
                      visible: selectedTime == null && isSubmitted == true,

                      child: Text(
                        AppLocalizations.of(context)!.event_time_error,
                        style: AppStyles.medium16Black.copyWith(
                          color: AppColors.redColor,
                        ),
                      ),
                    ),

                    // Location field
                    Text(
                      AppLocalizations.of(context)!.location,
                      style: Theme.of(context).textTheme.titleLarge,
                    ), 
                    SizedBox(height: height * 0.01),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.primaryLight,
                            ),
                            child: Icon(
                              Icons.my_location,
                              color: themeProvider.isDarkMode()
                                  ? AppColors.primaryDark
                                  : AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Text(
                            AppLocalizations.of(context)!.location_input,
                            style: AppStyles.medium16Primary,
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryLight,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    // Add Event button
                    CustomElevatedButton(
                      onPressed: () {
                        addEvent();
                      },
                      text: AppLocalizations.of(context)!.add_event,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
