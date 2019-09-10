import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';
import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'package:proxmox_dart_api_client/src/expiration_exception.dart';

class Client extends http.BaseClient {
  http.Client _httpClient;

  Credentials get credentials => _credentials;
  Credentials _credentials;

  Client(this._credentials,
      {http.Client httpClient})
      : _httpClient = httpClient == null ? getCustomIOHttpClient() : httpClient;

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (credentials.isExpired) {
      if (!credentials.canRefresh) throw ExpirationException(credentials);
      await refreshCredentials();
    }
    request.headers['Authorization'] = 'PVEAuthCookie ${credentials.ticket}';

    request.headers['CSRFPreventionToken'] = credentials.csrfToken;
    var response = await _httpClient.send(request);

    return response;
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
