import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => http.Client();

Future<String> getPlatformAwareOrigin() async => window.location.origin;

Future<void> storePlatformAwareOrigin(String origin) async =>
    throw UnimplementedError();

Future<String> getTicketFromStorage() async {
  return Uri.decodeFull(
      RegExp(r'(?:(?:^|.*;\s*)PVEAuthCookie\s*\=\s*([^;]*).*$)|^.*$')
              .firstMatch(document.cookie)
              ?.group(1) ??
          "");
}

Future<void> storeTicket(String ticket) async {
  document.cookie = 'PVEAuthCookie=$ticket';
}
