import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/add_event/widgets/date_or_time_widget.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventEditScreen extends StatefulWidget {
  const EventEditScreen({super.key});

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formateDate = '';
  TimeOfDay? selectedTime;
  String formateTime = '';
  String selectedEventImage = '';
  String selectedEventName = '';
  int selectedIndex = 0;
  bool isSubmitted = false;
  bool isInitialized = false;

  // Initialize the controllers and variables
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

  // Function to choose time
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

  // Function to update the event
  void updateEvent() {
    isSubmitted = true;
    setState(() {});
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final event = args['event'];
    final userId = args['userId'];
    var eventListProvider = Provider.of<EventListProvider>(
      context,
      listen: false,
    );

    if (formKey.currentState!.validate() == true &&
        selectedDate != null &&
        selectedTime != null) {
      // Combine selectedDate and selectedTime into a DateTime
      final updatedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      // Create updated event object (make sure to keep the event id)
      Event updatedEvent = Event(
        id: event.id,
        title: titleController.text,
        description: descriptionController.text,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventDataTime: updatedDateTime,
        eventTime: formateTime,
      );
      // Add the event to Firestore and update the event list
      // It uses the UserProvider to get the current user ID
      FirebaseUtils.updateEventInFirestore(updatedEvent, userId)
          .then((value) {
            ToastUtils.toastMsg(
              msg: AppLocalizations.of(context)!.event_update,
              backGroundColor: AppColors.primaryLight,
              textColor: AppColors.whiteColor,
            );
            // get all events => refresh
            eventListProvider.getAllEvents(userId);
            Navigator.pop(context);
            Navigator.pop(context); // double pop
          })
          .catchError((error) {
            ToastUtils.toastMsg(
              msg: AppLocalizations.of(context)!.failed_update_event,
              backGroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the EventListProvider to manage events and the AppThemeProvider for theme management
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final event = args['event'];

    // Initialize the controllers and variables
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

    // Initialize the controllers and variables
    if (!isInitialized && event != null) {
      titleController.text = event.title;
      descriptionController.text = event.description;
      selectedDate = event.eventDataTime;
      formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      selectedTime = TimeOfDay.fromDateTime(event.eventDataTime);
      formateTime = selectedTime!.format(context);

      // Assign the index based on the received event name
      selectedIndex = eventsNameList.indexOf(event.eventName);
      if (selectedIndex == -1) selectedIndex = 0; // fallback if not found

      selectedEventImage = eventsImageList[selectedIndex];
      selectedEventName = eventsNameList[selectedIndex];

      isInitialized = true;
    }

    selectedEventImage = eventsImageList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: AppStyles.medium20Primary,
        ),
      ),
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
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.title_error;
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.titleMedium,
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
                          return AppLocalizations.of(
                            context,
                          )!.description_error;
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.titleMedium,
                      colorBorderSide: themeProvider.isDarkMode()
                          ? AppColors.primaryLight
                          : AppColors.greyColor,
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      controller: descriptionController,
                      maxLines: 4,
                      hintText: AppLocalizations.of(context)!.description_input,
                    ),

                    SizedBox(height: height * 0.02),

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
                              color: AppColors.whiteColor,
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
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: updateEvent,
                      text: AppLocalizations.of(context)!.update_event,
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
