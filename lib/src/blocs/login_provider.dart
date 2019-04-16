import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final bloc = LoginBloc();

  // using non-default super class constructor
  LoginProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  // enables a descendant recursively find the nearest ancestor
  // which has a Provider and returns a Bloc instance
  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        LoginProvider) as LoginProvider).bloc;
  }
}
