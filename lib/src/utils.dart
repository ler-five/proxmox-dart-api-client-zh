import 'package:http/http.dart' as http;

http.Client getCustomIOHttpClient({bool validateSSL = true}) =>
    throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io.');

// Match for example scsi0 etc.
List<String?> matchEnumJsonFields(
    String field, int max, Map<String, dynamic> map) {
  List<String?> l = [];
  for (var i = 0; i < max; i++) {
    if (map.containsKey('$field$i')) {
      l.add(map['$field$i']);
    }
  }
  return l;
}
