import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => throw UnsupportedError(
    'Cannot create a client without dart:html or dart:io.');

String getPlatformAwareOrigin() =>
    throw UnsupportedError('Cannot get origin without dart:html');