import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';
import '../blocs/login_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
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

  Widget emailField(LoginBloc bloc) {
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

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          child: Text('${snapshot.data}'),
          color: Colors.lightBlue,
          onPressed:
          snapshot.hasData
              ? () {
            bloc.submit();
            Navigator.pushNamed(context, '/news', arguments: null);
          }
              : null,
        );
      },
    );
  }
}
