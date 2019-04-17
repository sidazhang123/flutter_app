import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';
import '../blocs/login_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    // find the bloc which this context belongs to
    final _bloc = LoginProvider.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(_bloc),
          passwordField(_bloc),
          Container(
            margin: EdgeInsets.only(top: 15.0),
          ),
          submitButton(_bloc),
        ],
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
        // everything added to sink will be automatically processed
        // through the stream by a transformer(handler)
        stream: bloc.email,
        // outputs are thrown back to sink and present in snapshot

        builder: (context, snapshot) {
          return TextField(
            // put input text into changeEmail and add it to sink
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                hintText: 'you@example.com',
                labelText: 'Email Address',
                errorText: snapshot.error),
            keyboardType: TextInputType.emailAddress,
          );
        });
  }

  Widget passwordField(LoginBloc bloc) {
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

  // submitValid stream throws true, when both email and password
  // have their desired inputs, and null otherwise.
  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
            child: Text('log in'),
          color: Colors.lightBlue,
            // onPressed: null makes the button disable -> don't you submit until validated
          onPressed:
          snapshot.hasData ? () {
            bloc.submit();
            // navigate to "news list", the 3rd screen
            Navigator.pushNamed(context, '/news', arguments: null);
          } : null
        );
      },
    );
  }

}
