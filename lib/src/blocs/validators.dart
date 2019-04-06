import 'dart:async';

//transformers
class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r"^\w+@\w+\.\w{2,4}$").hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Enter a valid email.");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (RegExp(r"^\w{6,10}$").hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError("Password must be at least 6 characters of [A-Z a-z 0-9]");
    }
  });
}
