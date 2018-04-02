import 'dart:async';
import 'package:dispenserx/routes.dart';
import 'package:dispenserx/screens/login/login_screen_presenter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> implements LoginScreenContract{//, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    //var authStateProvider = new AuthStateProvider();
    //authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin('travis@dev.com', '123456', _ctx);
      //moved this here to perform route
//      appRouter.pushReplacementTo(_ctx, '/bottom_navigation');
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

//  @override
//  onAuthStateChanged(AuthState state) {
//
//    if(state == AuthState.LOGGED_IN)
//      Navigator.of(_ctx).pushReplacementNamed("/home");
//  }

  //make login form
  Widget getLoginForm(){
    //create form
    var logo = new Image.asset(
      'assets/dispense_rx_logo.png',
      width: 100.0,
      height: 100.0,
    );
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Sign in"),
      //color: Colors.blue,
    );
    var loginForm = new Column(
      children: <Widget>[

        logo,
//
//        new Container(
//          decoration: new BoxDecoration(
//            image: new DecorationImage(
//                image: new AssetImage(
//                  "assets/dispense_rx_logo.png",
//                ),
//                fit: BoxFit.fill),
//          ),
//        ),

        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  //todo: edit validator
                  validator: (val) {
                    return val.length <= 0
                        ? "Username must have at least <=0 characters"
                        : null;
                  },
                  decoration: new InputDecoration(labelText: "Username" ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
    //end form creation
    return loginForm;
  }

  @override
  Widget build(BuildContext context) {
    //set context
    _ctx = context;

    //get form
    var loginForm = getLoginForm();

    return new Scaffold(
      appBar: null,//new AppBar(title: new Text("DispenseRx"),),
      key: scaffoldKey,
      body:
        new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              loginForm,
            ],
          ),
      ) ,
    );
  }
//

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(String user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
//    var db = new DatabaseHelper();
//    await db.saveUser(user);
//    var authStateProvider = new AuthStateProvider();
//    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}