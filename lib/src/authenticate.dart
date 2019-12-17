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

Future<Client> authenticate(
  String username,
  String password, {
  Uri authorizationEndpoint,
  http.Client httpClient,
}) async {
  if (httpClient == null) {
    httpClient = getCustomIOHttpClient();
  }

  if (username == null || password == null) {
    throw ArgumentError("Can't authenticate without username/password.");
  }

  if (authorizationEndpoint == null) {
    try {
      authorizationEndpoint =
          Uri.parse(getPlatformAwareOrigin() + '/api2/json/access/ticket');
    } on UnsupportedError catch (_) {
      throw ArgumentError(
          "Can't authenticate without an authorization endpoint.");
    }
  }

  var body = {'username': username, 'password': password};
  var response = await httpClient.post(authorizationEndpoint, body: body);

  var credentials = await handleAccessTicketResponse(
      response, username, authorizationEndpoint);
  return Client(
    credentials,
    httpClient: httpClient,
  );
}
