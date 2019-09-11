import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient() => http.Client();

Uri getPlatformHostname() => Uri.parse('http://${window.location.hostname}/api2/json/access/ticket');