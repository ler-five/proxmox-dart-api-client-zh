class ProxmoxApiException implements Exception {

  final String message;
  final Map<String, dynamic> details;

  ProxmoxApiException(this.message, [this.details]);

  @override
  String toString() {
    return message;
  }
}