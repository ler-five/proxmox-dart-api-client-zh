import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';
import 'package:proxmox_dart_api_client/src/models/serializers.dart';

import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';

/// Returns an authenticated client to work with if successful.
///
/// This is the function you are looking for if you want to interact with any
/// Proxmox API. You'll get a client to work with which will handle auth related
/// boilerplate e.g. refresh ticket to prevent expiration.

Future<ProxmoxApiClient> authenticate(
  String username,
  String password,
  Uri apiBaseUrl,
  bool validateSSL, {
  http.Client? httpClient,
}) async {
  httpClient ??= getCustomIOHttpClient(validateSSL: validateSSL);

  if (username == null || password == null) {
    throw ArgumentError("Can't authenticate without username/password.");
  }

  if (apiBaseUrl == null) {
    throw ArgumentError("Can't authenticate without apiBaseUrl");
  }

  var body = {'username': username, 'password': password};

  try {
    var credentials = Credentials(apiBaseUrl, username);

    var response = await httpClient
        .post(credentials.ticketUrl, body: body)
        .timeout(Duration(seconds: 5));

    credentials = handleAccessTicketResponse(response, credentials);

    return ProxmoxApiClient(
      credentials,
      httpClient: httpClient,
    );
  } on TimeoutException catch (_) {
    throw ProxmoxApiException(
        'Authentication takes unusually long, check network connection', 408);
  }
}

Future<List<PveAccessDomainModel>> accessDomains(
  Uri apiBaseUrl,
  bool validateSSL, {
  http.Client? httpClient,
}) async {
  httpClient ??= getCustomIOHttpClient(validateSSL: validateSSL);

  final path = '/api2/json/access/domains';
  final response = await httpClient
      .get(apiBaseUrl.replace(path: path))
      .timeout(Duration(seconds: 5));
  var data = (json.decode(response.body)['data'] as List).map((f) {
    return serializers.deserializeWith(PveAccessDomainModel.serializer, f);
  });
  return data.toList();
}
