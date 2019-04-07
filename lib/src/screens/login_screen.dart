import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';
import '../blocs/login_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          Container(
            margin: EdgeInsets.only(top: 15.0),
          ),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
        // everything added to sink will be automatically processed
        // through the stream by a transformer(handler)
        stream: bloc.email,
        //outputs are added back to sink and present in snapshot
        builder: (context, snapshot) {
          return TextField(
            //put input text into changeEmail and add it to sink
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                hintText: 'you@example.com',
                labelText: 'Email Address',
                //output sink
                errorText: snapshot.error),
            keyboardType: TextInputType.emailAddress,
          );
        });
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                hintText: 'password',
                labelText: 'Password',
                errorText: snapshot.error),
            obscureText: true,
          );
        });
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('login'),
          color: Colors.lightBlue,
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }
}
