//import 'dart:async';
//import 'dart:ui' as ui;
//
//import 'package:dispenserx/constants.dart';
//import 'package:dispenserx/routes.dart';
//import 'package:dispenserx/screens/bottom_navigation/bottom_navigation.dart';
//import 'package:dispenserx/services/firebase/authentication.dart';
//import 'package:flutter/material.dart';
//
//class LoginScreen extends StatefulWidget {
//  static const String route = '/login';
//
//  @override
//  State<StatefulWidget> createState() => new LoginScreenState();
//}
//
//class LoginScreenState extends State<LoginScreen> {
//  //, AuthStateListener {
//  BuildContext _ctx;
//
//  final formKey = new GlobalKey<FormState>();
//  final scaffoldKey = new GlobalKey<ScaffoldState>();
//
//  void _submit() async {
//    scaffoldKey.currentState.showSnackBar(
//      new SnackBar(
//        backgroundColor: Colors.white,
//        duration: new Duration(seconds: 4),
//        content: new Row(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text(
//              "  Signing-In...",
//              style: const TextStyle(
//                color: Constants.rxColor,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//    await UserAuth.signIn('travis@dev.com', '123456');
//    appRouter.pushReplacementTo(_ctx, BottomNavigation.route);
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    //set context
//    _ctx = context;
//    var boxContents = <Widget>[
//      new Padding(
//        padding: const EdgeInsets.only(top: 10.0),
//        child: new Divider(color: Colors.black),
//      ),
//      new Image.asset(
//        'assets/augmental_logo.jpg',
//        width: 200.0,
//        height: 200.0,
//      ),
//      new Image.asset(
//        'assets/augmental_name.png',
//        width: 200.0,
//        height: 100.0,
//      ),
//      //new Divider(color: Constants.augmentalColor),
//      new Image.asset(
//        'assets/augmental_slogan.png',
//        width: 180.0,
//        height: 60.0,
//      ),
//      new Padding(
//        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
//        child: new Divider(color: Colors.black),
//      ),
//      new RaisedButton(
//        onPressed: _submit,
//        child: new Text("Let's begin"),
//        color: Constants.rxColor,
//        textColor: Colors.white,
//      ),
//    ];
//
//    return new Scaffold(
//      appBar: null,
//      key: scaffoldKey,
//      backgroundColor: Colors.white,
//      body:
//      new Center(
//        child: new ClipRect(
//          child: new BackdropFilter(
//            filter: new ui.ImageFilter.blur(
//                sigmaX: 1.0, sigmaY: 1.0), //blur(sigmaX: 10.0, sigmaY: 10.0),
//            child: new Container(
//              width: 300.0,
//              height: 550.0,
//              decoration: new BoxDecoration(
//                border: new Border.all(width: 1.0, color: Colors.white),
//                borderRadius:
//                    const BorderRadius.all(const Radius.circular(8.0)),
//                // color: Colors.white,
//              ),
//              child: new Center(
//                child: new Column(children: boxContents),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
