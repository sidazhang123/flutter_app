import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/comments_bloc.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';
import '../widgets/loading_container.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail(this.itemId);

  @override
  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);
    commentsBloc.getItemWithComments(itemId);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: buildBody(commentsBloc),
    );
  }

  Widget buildBody(CommentsBloc commentsBloc) {
    return StreamBuilder(
      stream: commentsBloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();
    children.addAll(commentsList);
    return ListView(children: children);
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
