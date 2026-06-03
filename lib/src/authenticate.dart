import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';
import 'package:proxmox_dart_api_client/src/models/serializers.dart';
import 'package:objective_c/objective_c.dart';

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

  // FIXME: this was product agnostic, but new-format isn't?
  var body = {'username': username, 'password': password, 'new-format': '1'};

  try {
    var credentials = Credentials(apiBaseUrl, username);

    var response = await httpClient
        .post(credentials.ticketUrl, body: body)
        .timeout(Duration(seconds: 25));

    // for backward compat with older products, e.g. PVE < 7.1, retry without 'new-format'
    if (response.statusCode == 400) {
      print("retrying for backward compat!");
      final errors = jsonDecode(response.body)['errors'] ?? {};
      if (errors.containsKey('new-format')) {
        var body = {
          'username': username,
          'password': password,
        };
        response = await httpClient
            .post(credentials.ticketUrl, body: body)
            .timeout(Duration(seconds: 25));
      }
    }

    credentials = handleAccessTicketResponse(response, credentials);

    return ProxmoxApiClient(
      credentials,
      httpClient: httpClient,
    );
  } on TimeoutException catch (_) {
    throw ProxmoxApiException(
        'Authentication takes unusually long, check network connection', 408);
  } on NSErrorClientException catch (e) {
    // Treat untrusted server certificate (-1202) as a handshake failure.
    if (e.error.code == -1202) {
      throw HandshakeException(e.message);
    }
    rethrow;
  } on http.ClientException catch (e) {
    if (e.message.contains('net::ERR_CERT_AUTHORITY_INVALID')) {
      throw HandshakeException(e.message);
    }
    rethrow;
  }
}

Future<List<PveAccessDomainModel?>> accessDomains(
  Uri apiBaseUrl,
  bool validateSSL, {
  http.Client? httpClient,
}) async {
  try {
    httpClient ??= getCustomIOHttpClient(validateSSL: validateSSL);

    final path = '/api2/json/access/domains';
    final response = await httpClient
        .get(apiBaseUrl.replace(path: path))
        .timeout(Duration(seconds: 25));
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveAccessDomainModel.serializer, f);
    });
    return data.toList();
  } on NSErrorClientException catch (e) {
    // Treat untrusted server certificate (-1202) as a handshake failure.
    if (e.error.code == -1202) {
      throw HandshakeException(e.message);
    }
    rethrow;
  } on http.ClientException catch (e) {
    if (e.message.contains('net::ERR_CERT_AUTHORITY_INVALID')) {
      throw HandshakeException(e.message);
    }
    rethrow;
  }
}
