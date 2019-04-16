import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: buildText(context, item),
              subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
              contentPadding: EdgeInsets.only(
                left: depth * 16.0,
                right: 16.0,
              ),
            ),
            Divider(),
          ];
          item.kids.forEach((kidId) {
            children.add(Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ));
          });
          return Column(
            children: children,
          );
        });
  }

  Widget buildText(context, ItemModel item) {
//    final text = item.text
//        .replaceAll('&#x27', "'")
//        .replaceAll('<p>', '\n\n')
//        .replaceAll('</p>', '')
//    .replaceAll('&#x2F;', '/');
    return Html(
      data: item.text,
      onLinkTap: (url) {
        print("Opening $url...");
        return Navigator.pushNamed(context, '/webview',
            arguments: <String, String>{'url': url});
      },
    );
  }
}
