import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/proxmox_api_exception.dart';

extension ResponseValidation on http.Response {
  http.Response validate(bool extensive) {
    if (statusCode < 400) return this;
    var message = 'Request failed with status ${statusCode}';

    if (reasonPhrase != null) {
      message = '${statusCode}: ${reasonPhrase}';
    }
    var decodedErrors;

    if (extensive) {
      try {
        decodedErrors = json.decode(body);
      } catch (_) {}
    }

    throw ProxmoxApiException(
        message, statusCode, (decodedErrors ?? const {})['errors']);
  }
}
