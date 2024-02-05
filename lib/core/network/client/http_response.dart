class HttpResponse {
  final dynamic headers;
  final dynamic data;
  final int? statusCode;

  HttpResponse({
    required this.data,
    required this.headers,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'status_code: $statusCode, data: $data, headers: $headers';
  }
}
