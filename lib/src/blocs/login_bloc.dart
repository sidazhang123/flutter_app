import 'dart:async';

import 'package:flutter_app/src/mixins/login_form_validators.dart';
import 'package:rxdart/rxdart.dart';

/*
    Here comes a severe issue only shows on my physical Android device but the emulator.
    It could be due to the implementation of
    # route
    # StreamController
    # bloc acquisition
    # Textfield stream consumer
    # rxdart/flutter's compatibility with Huawei Honor devices

    which prevents one stream from yielding while tinkering with the other.
    '''
      typing in 'email' -> _emailController.value != null, _passwordController.value = null
      then
      typing in 'password' -> _emailController.value = null, _passwordController.value != null

      where _emailController should have kept the previous input.
    '''
    # Google上目前没有直接指向这个问题的答案，重点:“2个stream”
    # 似乎bloc是singleton，没有rebuild （每navigate一次会触发route stack中widgets的build()）
    # 可能和MaterialPageRoute嵌套blocProvider有关（应该provider在最外层）
    # 如果这是app实现的问题，目前已知global bloc可解, 但不优雅

   */

//'with' must come with a parent class to be inherited, and Object is generic
class LoginBloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //add data to streams
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //give true only when both of the streams yield (validate and give user's input)
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);


  //change data (get is the shorthand for getter)
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;


//  ee(String s){_emailController.sink.add(s);print("e:   ${_emailController.value}");print("p:   ${_passwordController.value}");}
//  pp(String s){_passwordController.sink.add(s);print("e:   ${_emailController.value}");print("p:   ${_passwordController.value}");}
  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print("validEmail: $validEmail");
    print("validPassword: $validPassword");

    //todo: send values to background APIs
  }

  // define methods to close the controllers
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
