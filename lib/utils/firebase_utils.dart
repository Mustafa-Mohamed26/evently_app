import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {
  // This method returns a reference to the events collection for a specific user.
  // It uses the user's ID to access their specific collection of events.
  static CollectionReference<Event> getEventsCollection(String uId) {
    // Access the user's document in the users collection
    // and then access the events collection within that document.
    return getUsersCollection()
        .doc(uId) // Access the user's document
        .collection(
          Event.collectionName,
        ) // Access the events collection within that user document
        .withConverter<Event>(
          // Use a converter to convert between Firestore data and Event objects
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  // This method returns a reference to the users collection in Firestore.
  // It uses a converter to convert between Firestore data and MyUser objects.
  static CollectionReference<MyUser> getUsersCollection() {
    // Access the users collection in Firestore and set up a converter
    // to convert Firestore documents to MyUser objects and vice versa.
    return FirebaseFirestore
        .instance // Access the Firestore instance
        .collection(MyUser.collectionName) // Access the users collection
        .withConverter<MyUser>(
          // Use a converter to convert between Firestore data and MyUser objects
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toFirestore(),
        );
  }

  // This method adds a user to the Firestore database.
  // It takes a MyUser object and saves it to the users collection.
  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  // This method reads a user from Firestore based on their ID.
  // It returns a MyUser object if found, or null if not found.
  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }

  // This method adds an event to Firestore.
  // It takes an Event object and the user's ID, and saves the event to the user's
  static Future<void> addEventToFireStore(Event event, String uId) {
    // Get a reference to the events collection for the user
    // and create a new document with an auto-generated ID.
    CollectionReference<Event> collectionRef = getEventsCollection(uId);

    // Create a new document reference with an auto-generated ID
    // and assign it to the event's ID.
    DocumentReference<Event> docRef = collectionRef.doc();

    // Set the event data in the document reference.
    // The event's ID is set to the document's ID.
    event.id = docRef.id; // auto id

    // Convert the event to Firestore format and save it in the document.
    // This method returns a Future that completes when the write is successful.
    return docRef.set(event);
  }

  // This method deletes an event from Firestore based on the user's ID and the event's ID.
  // It removes the specified event from the user's events collection.
  static Future<void> deleteEventFromFirestore(
    String userId,
    String eventId,
  ) async {
    await getEventsCollection(userId).doc(eventId).delete();
  }

  // This method updates an existing event in Firestore.
  // It takes an Event object and the user's ID, and updates the event's data in
  static Future<void> updateEventInFirestore(Event event, String userId) {
    return getEventsCollection(userId).doc(event.id).update({
      'id': event.id,
      'title': event.title,
      'description': event.description,
      'event_image': event.eventImage,
      'event_name': event.eventName,
      'event_time': event.eventTime,
      'event_data_time': event.eventDataTime.millisecondsSinceEpoch, // int
    });
  }

  
  // This method signs in a user with Google authentication.
  // It uses the Google Sign-In package to handle the authentication flow.
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Google sign-in aborted by user',
      );
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  
}

/// firebase => json => java script object notation
/// [] , {}
/// firebase => json
/// developers => object
/// json => object
/// object => json
