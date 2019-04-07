import 'package:flutter/material.dart';

import 'screens/news_screen.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      home: NewsList(),
    );
  }
}
