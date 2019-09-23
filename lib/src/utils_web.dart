import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => http.Client();

String getPlatformAwareOrigin() => window.location.origin;

String getTicketFromStorage() => Uri.decodeFull(RegExp(r'(?:(?:^|.*;\s*)PVEAuthCookie\s*\=\s*([^;]*).*$)|^.*$').firstMatch(document.cookie)?.group(1) ?? "");