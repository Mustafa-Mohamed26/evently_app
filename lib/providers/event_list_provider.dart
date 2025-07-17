import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
