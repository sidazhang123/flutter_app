import 'package:flutter/material.dart';

import 'blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'screens/news_screen.dart';


class News extends StatelessWidget {
  final int id;

  News(this.id);

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
          child: Scaffold(

            body: buildBody(),

          )),
    );
  }

  Widget buildBody() {
    if (id == null) {
      return NewsList();
    } else {
      return NewsDetail(id);
    }
  }


}
