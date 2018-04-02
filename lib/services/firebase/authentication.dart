import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser currentUser;
  static DocumentSnapshot profileDocument;
  static final analytics = new FirebaseAnalytics();


  static Future<bool> signIn (String email, String password) async{

    await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    if(await isSignedIn()){
      print('signed in');
      currentUser = await _auth.currentUser();
     // profileDocument = await Firestore.instance.collection('drivers/').document(currentUser.uid).get();
      profileDocument = await Firestore.instance.collection('drivers').document('12345').get();
      print(profileDocument);
      return true;
    }
    else{
      return false;
    }

  }

  Future test() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    print(currentUser.uid);

  }

  static Future<bool> isSignedIn() async {
    return await _auth.currentUser() != null;
  }
}
