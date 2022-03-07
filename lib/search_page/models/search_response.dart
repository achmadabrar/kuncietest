import 'package:kuncietestapp/search_page/models/result.dart';

class SearchResponse {
  int resultCount;
  List<Result> results;

  SearchResponse({required this.resultCount, required this.results});

  factory SearchResponse.fromJson(Map<String, dynamic>? json) {
    List<Result> results = List<Result>.from(json?['results'].map((model) => Result.fromJson(model)));
    return SearchResponse(resultCount: json?['resultCount'], results: results);
  }
}