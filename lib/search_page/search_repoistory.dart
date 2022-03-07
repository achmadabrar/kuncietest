import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/search_response.dart';

class SearchRepository {

  Future<SearchResponse> fetchMusic(int startIndex, int limitLoad) async {
    final queryFetch = {
      'term' : 'beatles',
      'entity': 'musicTrack',
      'limit': limitLoad.toString()
    };
    final response = await http.get(
        Uri.https('itunes.apple.com', '/search', queryFetch));
    print(Uri.https('itunes.apple.com', '/search', queryFetch));
    if (response.statusCode == 200) {
      print(json.decode(response.body).toString());
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      print(Exception(json.decode(response.body)));
      throw Exception(json.decode(response.body));
    }
  }
}