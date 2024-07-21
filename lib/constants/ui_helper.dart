const String api = 'http://90.110.196.159:3001/api';

class ResponseModel {
  final Map<String, dynamic> content;
  final int httpCode;
  final String? reasonPhrase;

  const ResponseModel(
      {required this.content,
      required this.httpCode,
      required this.reasonPhrase});
}
