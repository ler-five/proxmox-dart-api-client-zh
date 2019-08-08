import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;

import 'dart:io';
import 'dart:convert';


class Credentials {
  /// The URL of the authorization server
  final Uri ticketEndpoint;

  final String ticket;

  final String csrfToken;

  final DateTime expiration;

  bool get canRefresh => ticket != null && ticketEndpoint != null;


  Credentials(this.ticketEndpoint, {this.ticket, this.csrfToken, this.expiration});

  Future<Credentials> refresh(
      {String identifier, String secret, http.Client httpClient}) async {
    if (httpClient == null) {
      // This most probably breaks flutter web support, as for now dart:io isn't
      // available in flutter web
      final dartIoHttpClient = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) {
          // tests that cert is self signed, correct subject and correct date(s)
          // return (cert.issuer == cert.subject &&
          //     cert.subject == 'MySelfSignedCertCN' &&
          //     cert.endValidity.millisecondsSinceEpoch == 1234567890)
          return true;
        });

      httpClient = http_io.IOClient(dartIoHttpClient);
    }

    if (ticket == null) {
      throw ArgumentError("Can't refresh credentials without valid ticket");
    }

    if (ticketEndpoint == null) {
      throw ArgumentError(
          "Can't refresh credentials without a token endpoint.");
    }
    var startTime = DateTime.now();

    var body = {'username': identifier, 'password': ticket};

    var response = await httpClient.post(ticketEndpoint, body: body);
    var credentials =
        await handleAccessTicketResponse(response, ticketEndpoint, startTime);

    return credentials;
  }

  Credentials handleAccessTicketResponse(
      http.Response response, Uri ticketEndpoint, DateTime startTime) {
    if (response.statusCode != 200) {
      // TODO handle status codes != 200
      throw "State not handled";
    }

    final bodyJson = jsonDecode(response.body)['data'];;
    final ticket = bodyJson['ticket'];
    final csrfToken = bodyJson['CSRFPreventionToken'];
    final ticketRegex =
        RegExp(r"PVE:(?:(\S+):)?([A-Z0-9]{8})").firstMatch(bodyJson['ticket']);
    final time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(ticketRegex.group(2), radix: 16) * 1000);

    return Credentials(
      ticketEndpoint, ticket: ticket, csrfToken: csrfToken, expiration: time
    );
  }
}
