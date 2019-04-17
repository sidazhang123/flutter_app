import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = BehaviorSubject<int>();
  final _commentsOutput = PublishSubject<Map<int, Future<ItemModel>>>();

  //getters to streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //getters to sinks
  Function(int) get getItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          // recursion: add kids(& kids' kids) to sink to go thru this transformer.
          item.kids.forEach((kidId) => getItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
