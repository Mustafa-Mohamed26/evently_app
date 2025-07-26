import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toFirestore(),
        );
  }

  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }

  // signin with google

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

  static Future<void> addEventToFireStore(Event event, String uId) {
    // collection
    CollectionReference<Event> collectionRef = getEventsCollection(uId);

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
