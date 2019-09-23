import 'package:http/http.dart' as http;

import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';

class Credentials {
  /// The URL of the authorization server
  final Uri ticketEndpoint;

  final String username;

  final String ticket;

  final String csrfToken;

  final DateTime expiration;

  bool get canRefresh => ticket != null && ticketEndpoint != null;

  bool get isExpired =>
      expiration != null &&
      DateTime.now().isAfter(expiration.add(Duration(hours: 1)));

  Credentials(this.ticketEndpoint, this.username,
      {this.ticket, this.csrfToken, this.expiration});

  factory Credentials.fromPlatformStorage() {
    final endpoint =
        Uri.parse(getPlatformAwareOrigin() + '/api2/json/access/ticket');
    final ticket = getTicketFromStorage();
    if (ticket == "") throw ArgumentError('Ticket not found');

    final matches = RegExp(r"PVE:(?:(\S+):)?([A-Z0-9]{8})").firstMatch(ticket)?.groups([1,2]);

    final username = matches[1];
    if (username == null) throw FormatException('No username - invalid cookie format');

    final time = DateTime.fromMillisecondsSinceEpoch(int.parse(matches[2], radix: 16) * 1000);
    if (time == null) throw FormatException('No expiration time - invalid cookie format');

    return Credentials(endpoint, username, ticket: ticket, expiration: time);
  }

  Future<Credentials> refresh({http.Client httpClient}) async {
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
    var credentials = await handleAccessTicketResponse(
        response, username, ticketEndpoint, startTime);

    return credentials;
  }
}
