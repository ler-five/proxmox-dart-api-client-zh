import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'dart:io';

http.Client getCustomIOHttpClient({bool validateSSL = true}) {
  var ioClient = HttpClient();

  const cacheMaxSizeInBytes = 1024 * 1024;
  if (Platform.isAndroid && validateSSL) {
    final engine = CronetEngine.build(
      cacheMaxSize: cacheMaxSizeInBytes,
      cacheMode: CacheMode.memory,
    );
    return CronetClient.fromCronetEngine(
      engine,
      closeEngine: true,
    );
  }

  if (Platform.isIOS && validateSSL) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..cache = URLCache.withCapacity(memoryCapacity: cacheMaxSizeInBytes);
    return CupertinoClient.fromSessionConfiguration(config);
  }

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
