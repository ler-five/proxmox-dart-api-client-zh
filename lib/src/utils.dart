import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => throw UnsupportedError(
    'Cannot create a client without dart:html or dart:io.');

String getPlatformAwareOrigin() =>
    throw UnsupportedError('Cannot get origin without dart:html');

String getTicketFromStorage() =>
    throw UnsupportedError('Cannot get ticket without dart:html or dart:io.');

void storeTicket(String ticket) =>
    throw UnsupportedError('Cannot store ticket without dart:html or dart:io.');
