import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/proxmox_api_exception.dart';

extension ResponseValidation on http.Response {
  http.Response validate(bool extensive) {
    if (this.statusCode < 400) return this;
    var message = 'Request failed with status ${this.statusCode}';

    if (this.reasonPhrase != null) {
      message = '${this.statusCode}: ${this.reasonPhrase}';
    }
    var decodedErrors;

    if (extensive) {
      try {
        decodedErrors = json.decode(this.body);
      } catch (_) {}
    }

    throw ProxmoxApiException(
        message, this.statusCode, (decodedErrors ?? const {})['errors']);
  }
}
