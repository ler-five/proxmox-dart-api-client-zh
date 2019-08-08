import 'package:http/http.dart' as http;

import 'package:proxmox_api_client/src/handle_ticket_response.dart';
import 'package:proxmox_api_client/src/utils.dart';

class Credentials {
  /// The URL of the authorization server
  final Uri ticketEndpoint;

  final String username;

  final String ticket;

  final String csrfToken;

  final DateTime expiration;

  bool get canRefresh => ticket != null && ticketEndpoint != null;

  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration.add(Duration(hours: 1)));

  Credentials(this.ticketEndpoint, this.username,
      {this.ticket, this.csrfToken, this.expiration});

  Future<Credentials> refresh(
      {http.Client httpClient}) async {
    if (httpClient == null) httpClient = getCustomIOHttpClient();

    if (ticket == null) {
      throw ArgumentError("Can't refresh credentials without valid ticket");
    }

    if (username == null) {
      throw ArgumentError("Can't refresh credentials without valid ticket");
    }

    if (ticketEndpoint == null) {
      throw ArgumentError(
          "Can't refresh credentials without a token endpoint.");
    }
    var startTime = DateTime.now();

    var body = {'username': username, 'password': ticket};

    var response = await httpClient.post(ticketEndpoint, body: body);
    var credentials =
        await handleAccessTicketResponse(response, username, ticketEndpoint, startTime);

    return credentials;
  }


}
