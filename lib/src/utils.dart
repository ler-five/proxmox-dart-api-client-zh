import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => throw UnsupportedError(
    'Cannot create a client without dart:html or dart:io.');

Future<String> getPlatformAwareOrigin() async =>
    throw UnsupportedError('Cannot get origin without dart:html or dart:io.');

Future<void> storePlatformAwareOrigin(String origin) async =>
    throw UnsupportedError('Cannot store origin without dart:html or dart:io.');

Future<String> getTicketFromStorage([String name]) async =>
    throw UnsupportedError('Cannot get ticket without dart:html or dart:io.');

Future<void> storeTicket(String ticket, [String name]) async =>
    throw UnsupportedError('Cannot store ticket without dart:html or dart:io.');
