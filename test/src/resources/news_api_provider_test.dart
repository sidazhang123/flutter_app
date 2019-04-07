import 'dart:convert';

import 'package:flutter_app/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test_api/test_api.dart';

void main() {
  test('FetchTopIds returns a list of ids.', () async {
    //setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    //expectation
    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item model.', () async {
    //setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123, 'by': 'dhouston'};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);
    //expectation
    expect(item, {'id': 123, 'by': 'dhouston'});
  });
}
