import 'package:dispenserx/routes.dart';
import 'package:dispenserx/screens/bottom_navigation/bottom_navigation.dart';
import 'package:dispenserx/services/firebase/authentication.dart';
import 'package:flutter/material.dart';


abstract class LoginScreenContract {
  void onLoginSuccess(String user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  LoginScreenPresenter(this._view);

  doLogin(String username, String password, BuildContext ctx) async {
    print('$username with password $password');
    print(_view.toString());
    if (await UserAuth.signIn(username, password)) {
      appRouter.pushReplacementTo(ctx, BottomNavigation.route);
    }
    else{
      appRouter.pushReplacementTo(ctx, '/');
    }
  }


}