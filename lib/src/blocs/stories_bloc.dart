import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';


class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  final _itemsOuput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOuput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  // get items from network source or local cache => pipe into another stream for
  // broadcasting to Tiles
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer())
        .pipe(_itemsOuput);
  }

  // marked repository as private
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
          (Map<int, Future<ItemModel>> cache, int id, index) {
//        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsOuput.close();
    _itemsFetcher.close();
  }
}
