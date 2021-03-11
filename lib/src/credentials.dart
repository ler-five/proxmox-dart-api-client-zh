import 'package:http/http.dart' as http;

import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';

const String ticketPath = '/api2/json/access/ticket';
const String tfaPath = '/api2/json/access/tfa';

class Credentials {
  /// The URL of the authorization server
  final Uri apiBaseUrl;

  final String username;

  final String? ticket;

  final String? csrfToken;

  final DateTime? expiration;

  bool tfa;

  bool get canRefresh => ticket != null;

  bool get isExpired =>
      expiration != null &&
      DateTime.now().isAfter(expiration!.add(Duration(hours: 1)));

  Uri get ticketUrl => apiBaseUrl.replace(path: ticketPath);

  Uri get tfaUrl => apiBaseUrl.replace(path: tfaPath);

  Credentials(
    this.apiBaseUrl,
    this.username, {
    this.ticket,
    this.csrfToken,
    this.expiration,
    this.tfa = false,
  });

  Future<Credentials> refresh({http.Client? httpClient}) async {
    httpClient ??= getCustomIOHttpClient();

    if (ticket == null) {
      throw ArgumentError("Can't refresh credentials without valid ticket");
    }

    var body = {'username': username, 'password': ticket};

    var response = await httpClient
        .post(ticketUrl, body: body)
        .timeout(Duration(seconds: 5));

    var credentials = handleAccessTicketResponse(response, this);

    return credentials;
  }

  Future<Credentials> tfaChallenge(String code,
      {http.Client? httpClient}) async {
    httpClient ??= getCustomIOHttpClient();

    final body = {'response': code};

    final response = await httpClient.post(tfaUrl, body: body);

    final credentials = handleTfaChallengeResponse(response, this);

    return credentials;
  }
}
