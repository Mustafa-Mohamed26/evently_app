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
  int selectedIndex = 0;
  String selectedEventImage = '';
  String selectedEventName = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String formateDate = '';
  TimeOfDay? selectedTime;
  String formateTime = '';
  bool isSubmitted = false;
  bool isInitialized = false;

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

      FirebaseUtils.updateEventInFirestore(updatedEvent, userId)
          .then((value) {
            ToastUtils.toastMsg(
              msg: "Event updated Successfully",
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
              msg: "Failed to update event",
              backGroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final event = args['event'];
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
          "Edit Event",
          style: AppStyles.medium20Primary,
        ), // TODO: Localize
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(eventsImageList[selectedIndex]),
              ),
              SizedBox(height: height * 0.02),
              //TODO: handle the color of the list view in dark mode
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
                        borderColor: AppColors.primaryLight,
                        unSelectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineMedium,

                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineSmall,
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
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Title",
                      style: Theme.of(context).textTheme.titleLarge,
                    ), //TODO: Localization
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter event title'; //TODO: Localization
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
                      hintText: "Event Title", //TODO: Localization
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleLarge,
                    ), //TODO: Localization
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter event description'; //TODO: Localization
                        }
                        return null;
                      },
                      colorBorderSide: themeProvider.isDarkMode()
                          ? AppColors.primaryLight
                          : AppColors.greyColor,
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      controller: descriptionController,
                      maxLines: 4,
                      hintText: "Event Description", //TODO: Localization
                    ),
                    SizedBox(height: height * 0.02),
                    //TODO: add validation to the time and data
                    DateOrTimeWidget(
                      iconDateOrTime: Icons.calendar_month_outlined,
                      eventDateOrTime: "Event Date", //TODO: Localization
                      chooseDateOrTime: selectedDate == null
                          ? "Choose Date"
                          : formateDate, //'${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}', //TODO: Localization
                      onChooseDateOrTimeClick: chooseDate,
                    ),
                    Visibility(
                      visible: selectedDate == null && isSubmitted == true,
                      child: Text(
                        "Please Choose Date",
                        style: AppStyles.medium16Black.copyWith(
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                    DateOrTimeWidget(
                      iconDateOrTime: Icons.timelapse_rounded,
                      eventDateOrTime: "Event Time", //TODO: Localization
                      chooseDateOrTime: selectedTime == null
                          ? "Choose Time" //TODO: Localization
                          : formateTime,
                      onChooseDateOrTimeClick: chooseTime,
                    ),
                    Visibility(
                      visible: selectedTime == null && isSubmitted == true,

                      child: Text(
                        "Please Choose Time",
                        style: AppStyles.medium16Black.copyWith(
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Location",
                      style: Theme.of(context).textTheme.titleLarge,
                    ), //TODO: Localization
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
                            "Choose Event Location", //TODO: Localization
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
                      text: "Update Event", //TODO: Localization
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
