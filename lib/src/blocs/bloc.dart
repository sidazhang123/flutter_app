import 'dart:async';
import 'validators.dart';

//'with' must attach to a parent class to be inherited, and Object is generic
class Bloc extends Object with Validators {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  //add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //change data (get means getter)
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  // methods to close the controllers
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
