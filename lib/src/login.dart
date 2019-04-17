import 'package:flutter/material.dart';

import 'blocs/login_provider.dart';
import 'screens/login_screen.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*  Bloc pattern uses Reactive Programming to
        handle the flow of data within an app.

        Because a scoped, rather than global, bloc pattern is used,
        LoginProvider helps a widget to find the bloc which
        initialised at and attached to an ancestor along with the widget tree.
    */
    return LoginProvider(
        child: Scaffold(
          appBar: AppBar(
            title: Text('log me in'),
          ),
          body: LoginScreen(),
        ));
  }
}
