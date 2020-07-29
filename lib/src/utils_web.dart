import 'dart:html';

import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient({bool validateSSL = true}) => http.Client();
