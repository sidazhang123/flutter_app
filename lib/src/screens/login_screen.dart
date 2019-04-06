import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../blocs/bloc.dart';

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
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
        // everything added to sink will be automatically processed
        // through the stream by a transformer(handler)
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            //put input text into changeEmail and add it to sink
            //outputs are also present here
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

  Widget submitButton() {
    return RaisedButton(
      child: Text('login'),
      color: Colors.lightBlue,
      onPressed: () {},
    );
  }
}
