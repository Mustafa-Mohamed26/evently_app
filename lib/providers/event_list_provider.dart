import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filteredEventList = [];
  List<String> eventsNameList = [];
  int selectedIndex = 0;

  List<String> getEventsNameList(BuildContext context) {
    return eventsNameList = [
      AppLocalizations.of(context)!.category_all,
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
  }

  // get all events
  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredEventList = eventList; // all events
    filteredEventList.sort((event1, event2) {
      return event1.eventDataTime.compareTo(event2.eventDataTime);
    });
    // compare to return 1 if event1 > event2
    // compare to return -1 if event1 < event2
    // compare to return 0 if event1 == event2
    notifyListeners();
  }

  // get filtered events
  void getFilteredEvents() async {
    var querySnapshot = await FirebaseUtils.getEventsCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredEventList = eventList.where((event) {
      // if (event.eventName == eventsNameList[selectedIndex]) {
      //   return true;
      // } else {
      //   return false;
      // }
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();
    filteredEventList.sort((event1, event2) {
      return event1.eventDataTime.compareTo(event2.eventDataTime);
    });
    // compare to return 1 if event1 > event2
    // compare to return -1 if event1 < event2
    // compare to return 0 if event1 == event2
    notifyListeners();
  }

  void getFilteredEventsFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getEventsCollection()
        .orderBy('event_data_time', descending: false)
        .where('event_name', isEqualTo: eventsNameList[selectedIndex])
        .get();

    filteredEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  // change selected index
  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilteredEventsFromFireStore();
  }
}
