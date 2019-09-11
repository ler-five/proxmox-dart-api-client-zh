import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => throw UnsupportedError(
    'Cannot create a client without dart:html or dart:io.');

Uri getPlatformHostname() => throw UnsupportedError(
    'No default hostname for native target');