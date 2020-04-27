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

  bool tfa;

  bool get canRefresh => ticket != null && ticketEndpoint != null;

  bool get isExpired =>
      expiration != null &&
      DateTime.now().isAfter(expiration.add(Duration(hours: 1)));

  Credentials(this.ticketEndpoint, this.username,
      {this.ticket, this.csrfToken, this.expiration, this.tfa = false});

  // Factory constructors can't be async....
  static Future<Credentials> fromPlatformStorage([String name = 'PVE']) async {
    final origin = await getPlatformAwareOrigin();
    if (origin == null || origin.isEmpty)
      throw ArgumentError('Could not determine origin');

    final ticketEndpoint = Uri.parse('$origin/api2/json/access/ticket');

    final ticket = await getTicketFromStorage();
    if (ticket == null || ticket.isEmpty)
      throw ArgumentError('Ticket not found');

    final matches = RegExp(r"(?:PVE|PMG|PMGQUAR):(?:(\S+):)?([A-Z0-9]{8})")
        .firstMatch(ticket);
    if (matches == null) throw FormatException('invalid cookie format');

    final username = matches.group(1);
    if (username == null)
      throw FormatException('No username - invalid cookie format');

    final time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(matches.group(2), radix: 16) * 1000);
    if (time == null)
      throw FormatException('No expiration time - invalid cookie format');

    return Credentials(ticketEndpoint, username,
        ticket: ticket, expiration: time);
  }

  Future<Credentials> refresh({http.Client httpClient}) async {
    httpClient ??= getCustomIOHttpClient();

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

    var body = {'username': username, 'password': ticket};

    var response = await httpClient.post(ticketEndpoint, body: body);
    var credentials =
        await handleAccessTicketResponse(response, username, ticketEndpoint);

    return credentials;
  }

  Future<Credentials> tfaChallenge(String code,
      {http.Client httpClient}) async {
    httpClient ??= getCustomIOHttpClient();
    final origin = await getPlatformAwareOrigin();

    final body = {'response': code};
    final response =
        await httpClient.post(origin + "/api2/json/access/tfa", body: body);
    final credentials = await handleTfaChallengeResponse(response, this);
    return credentials;
  }
}
