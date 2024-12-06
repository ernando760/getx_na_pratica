class HttpClientResponse {
  final Map<String, dynamic> data;
  final int? statusCode;

  HttpClientResponse({
    this.data = const {},
    this.statusCode,
  });
}
