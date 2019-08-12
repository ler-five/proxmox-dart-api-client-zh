import 'package:http/http.dart' as http
  if(dart.library.io) 'utils_native.dart'
  if(dart.library.html) 'utils_web.dart';

http.Client getCustomIOHttpClient() => throw UnsupportedError(
    'Cannot create a client without dart:html or dart:io.');
