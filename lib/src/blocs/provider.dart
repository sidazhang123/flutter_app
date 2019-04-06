import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  // enables a descendant recursively find the nearest ancestor
  // which has a Provider and returns a Bloc instance
  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
