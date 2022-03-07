class Result {
  String trackName;
  String artistName;
  String collectionCensoredName;
  String trackViewUrl;

  Result({required this.trackName, required this.artistName, required this.collectionCensoredName, required this.trackViewUrl});

  factory Result.fromJson(Map<String, dynamic>? json) {
    return Result(trackName: json?['trackName'], artistName: json?['artistName'], collectionCensoredName: json?['collectionCensoredName'], trackViewUrl: json?['trackViewUrl']);
  }
}