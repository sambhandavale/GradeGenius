class ApiException implements Exception {
  final int? statusCode;
  final dynamic data;

  ApiException(this.statusCode, this.data);

  @override
  String toString() {
    return 'ApiException: $statusCode - $data';
  }
}
