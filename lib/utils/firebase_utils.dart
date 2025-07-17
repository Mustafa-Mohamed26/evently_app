import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    // collection
    CollectionReference<Event> collectionRef = getEventsCollection();

    // document
    DocumentReference<Event> docRef = collectionRef.doc();

    // assign auto doc id to event id
    event.id = docRef.id; // auto id

    return docRef.set(event);

    
  }
}

/// firebase => json => java script object notation
/// [] , {}
/// firebase => json
/// developers => object
/// json => object
/// object => json
