import 'package:flutter/material.dart';

import 'screens/cat_screen.dart';

class CatAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Home(),
    );
  }
}
