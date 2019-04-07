import 'dart:async';

import 'package:flutter_app/src/mixins/validators.dart';
import 'package:rxdart/rxdart.dart';

//'with' must attach to a parent class to be inherited, and Object is generic
class Bloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  //change data (get means getter)
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;


  submit() {
    final validEmail = _emailController.value.trim();
    final validPassword = _passwordController.value.trim();
    print("validEmail: $validEmail");
    print("validEmail: $validPassword");
  }
  // methods to close the controllers
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
