class ProxmoxApiException implements Exception {

  final String message;
  final int statusCode;
  final Map<String, dynamic> details;

  ProxmoxApiException(this.message, this.statusCode, [this.details]);

  @override
  String toString() {
    return message;
  }
}