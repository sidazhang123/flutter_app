import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);
    storiesBloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(storiesBloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        // the circular loading animation
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        /* Wrap the ListView in a Refresh Widget which ,when you "pull down",
           clears the cache, fetches new ids, and triggers NewsListTile to rebuild.

        */
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              // flutter decides how many tiles to render together and passes "index" in
              itemBuilder: (context, int index) {
                bloc.fetchItem(snapshot.data[index]);
                return NewsListTile(
                  itemId: snapshot.data[index],
                );
              }),
        );
      },
    );
  }
}
