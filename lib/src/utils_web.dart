import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => http.Client();

String getPlatformAwareOrigin() => window.location.origin;