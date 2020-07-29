import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'dart:io';

http.Client getCustomIOHttpClient({bool validateSSL = true}) {
  var ioClient = HttpClient();

  if (!validateSSL) {
    ioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      // tests that cert is self signed, correct subject and correct date(s)
      // return (cert.issuer == cert.subject &&
      //     cert.subject == 'MySelfSignedCertCN' &&
      //     cert.endValidity.millisecondsSinceEpoch == 1234567890)
      return true;
    });
  }

  return http_io.IOClient(ioClient);
}
