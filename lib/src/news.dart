import 'package:flutter/material.dart';

import 'blocs/stories_provider.dart';
import 'screens/news_screen.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
      title: 'News',
      home: NewsList(),
        ));
  }
}
