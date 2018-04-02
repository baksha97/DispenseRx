import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
//  static String displayName;
//  static String email;
  static final analytics = new FirebaseAnalytics();


  static Future<bool> signIn (String email, String password) async{

    await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    if(await isSignedIn()){
      return true;
    }
    else{
      return false;
    }
  }


  static Future<bool> isSignedIn() async {
    return await _auth.currentUser() != null;
  }
}
