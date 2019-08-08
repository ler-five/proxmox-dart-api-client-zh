import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'dart:io';

import 'package:proxmox_api_client/src/credentials.dart';

class Client extends http.BaseClient {
  http.Client _httpClient;
  String ticket;
  String csrfToken;

  Credentials get credentials => _credentials;
  Credentials _credentials;

  Client([this.ticket, this.csrfToken]) : _httpClient = getProxmoxHttpClient();

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (ticket != null) request.headers['Cookie'] = 'PVEAuthCookie=$ticket';
    if (csrfToken != null) request.headers['CSRFPreventionToken'] = csrfToken;

    return await _httpClient.send(request);
  }

  static http.Client getProxmoxHttpClient() {
    var ioClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        // tests that cert is self signed, correct subject and correct date(s)
        // return (cert.issuer == cert.subject &&
        //     cert.subject == 'MySelfSignedCertCN' &&
        //     cert.endValidity.millisecondsSinceEpoch == 1234567890)
        return true;
      });

    return http_io.IOClient(ioClient);
  }

  Future<Client> refreshCredentials() async {
    if (!credentials.canRefresh) {
      throw StateError("Credentials can't be refreshed.");
    }

    _credentials = await credentials.refresh(httpClient: _httpClient);

    return this;
  }

  /// Closes this client and its underlying HTTP client.
  void close() {
    if (_httpClient != null) _httpClient.close();
    _httpClient = null;
  }
}
