import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      title: 'log me in',
      home: Scaffold(
        body: LoginScreen(),
      ),
    ));
  }
}
