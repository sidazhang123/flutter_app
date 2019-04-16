import 'package:flutter/material.dart';

import 'blocs/login_provider.dart';
import 'screens/login_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
        child: Scaffold(
          appBar: AppBar(
            title: Text('log me in'),
          ),
          body: LoginScreen(),
    ));
  }
}
