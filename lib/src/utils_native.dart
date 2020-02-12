import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

http.Client getCustomIOHttpClient() {
  var ioClient = HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
      // tests that cert is self signed, correct subject and correct date(s)
      // return (cert.issuer == cert.subject &&
      //     cert.subject == 'MySelfSignedCertCN' &&
      //     cert.endValidity.millisecondsSinceEpoch == 1234567890)
      return true;
    });

  return http_io.IOClient(ioClient);
}

Future<String> getPlatformAwareOrigin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('origin');
}

Future<void> storePlatformAwareOrigin(String origin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('origin', origin);
}

Future<String> getTicketFromStorage([String name]) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('ticket');
}

Future<void> storeTicket(String ticket, [String name]) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('ticket', ticket);
}
