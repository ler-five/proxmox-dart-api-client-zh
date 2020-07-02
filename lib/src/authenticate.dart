import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';

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
  String password, {
  Uri authorizationEndpoint,
  http.Client httpClient,
}) async {
  httpClient ??= getCustomIOHttpClient();

  if (username == null || password == null) {
    throw ArgumentError("Can't authenticate without username/password.");
  }

  if (authorizationEndpoint == null) {
    final origin = await getPlatformAwareOrigin();

    if (origin.isEmpty) {
      throw ArgumentError(
          'Could not determine origin. You can manually assign a authorization endpoint to overcome this.');
    }

    authorizationEndpoint = Uri.parse('$origin/api2/json/access/ticket');
  }
  try {
    await storePlatformAwareOrigin(authorizationEndpoint.origin);
  } on UnimplementedError {
    print("couldn't store origin, due to platform implemention missing");
  }

  var body = {'username': username, 'password': password};
  try {
    var response = await httpClient
        .post(authorizationEndpoint, body: body)
        .timeout(Duration(seconds: 5));
    var credentials = await handleAccessTicketResponse(
        response, username, authorizationEndpoint);
    return ProxmoxApiClient(
      credentials,
      httpClient: httpClient,
    );
  } on TimeoutException catch (_) {
    throw ProxmoxApiException(
        'Authentication takes unusually long, check network connection', 408);
  }
}
