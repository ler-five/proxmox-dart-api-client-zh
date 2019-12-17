import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

Matcher throwsProxmoxApiException(message, statusCode) =>
    throwsA(isA<ProxmoxApiException>()
        .having((e) => e.message, 'message ', message)
        .having((e) => e.statusCode, 'http status code', statusCode));

void main() {
  setUp(() {});
  group("Response validation", () {
    test('pass validation', () {
      var response = http.Response("no error", 200).validate(false);
      expect(response.body, equals("no error"));
    });

    test('fail >= 400', () {
      var response = http.Response("", 400);
      expect(
          () => response.validate(false),
          throwsProxmoxApiException(
              "Request failed with status 400", equals(400)));
    });

    test('fail >= 400 with reason phrase', () {
      var response = http.Response("", 400, reasonPhrase: "this did not work");
      expect(
          () => response.validate(false),
          throwsProxmoxApiException(
              "400: this did not work", equals(400)));
    });
  });
}
