import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => http.Client();

Future<String> getPlatformAwareOrigin() async => window.location.origin;

Future<void> storePlatformAwareOrigin(String origin) async =>
    throw UnimplementedError();

Future<String> getTicketFromStorage([String name = 'PVE']) async {
  return Uri.decodeFull(
      RegExp(r'(?:(?:^|.*;\s*)' + name + r'AuthCookie\s*\=\s*([^;]*).*$)|^.*$')
              .firstMatch(document.cookie)
              ?.group(1) ??
          '');
}

Future<void> storeTicket(String ticket, [String name = 'PVE']) async {
  document.cookie = '${name}AuthCookie=$ticket';
}
