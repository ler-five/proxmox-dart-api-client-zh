import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/handle_ticket_response.dart';
import 'package:test/test.dart';

Matcher throwsProxmoxApiException(message, statusCode) =>
    throwsA(isA<ProxmoxApiException>()
        .having((e) => e.message, 'message ', message)
        .having((e) => e.statusCode, 'http status code', statusCode));

void main() {
  Uri dummyEndpoint = Uri.parse("https://localhost/auth");

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
      expect(() => response.validate(false),
          throwsProxmoxApiException("400: this did not work", equals(400)));
    });

    test('valid credentials extraction', () {
      final ticket =
          "PVE:root@pam:5DF8EC22::STV4HNO1wplmsyMDM5s6SUsU4cS7sBBBw+HOCEhSSV+6WGtz3zwIzHqBhq/ziJoBs7NqqyLXG4wn9jXJCMdYht+ndqwxtdFQsUNOF1Q/eTWwcyl+Q1fmPNOIIUoxMY8OqGBVozgIimiAJxdqm+2SJnrPEmlJge6m3yf/OEVAkKFCfRMOtSuyVnIbuLx6h6obvezBUP5+ZHzeTMmmXcH4rOsOKgW9XfwryLHbkjjq9Ennx0xjQaBD9Bo5ERquY0hNmWcdPC/p7ZzILTr4xH9sJe9Na2z6GhgJyTgOCAMengyIegySMq7IKIkmsp8odF4/iIC3005/XLF4w/DjPYQUMA==";
      final csrfToken = "5DF8EDEC:/bb44xdHyVQDo2eD/8ty0WVXwMgwt1HjhVHLZX2YbxQ";
      var response = http.Response(
          '{"data":{"clustername":"testcluster","username":"root@pam","CSRFPreventionToken":"5DF8EDEC:/bb44xdHyVQDo2eD/8ty0WVXwMgwt1HjhVHLZX2YbxQ","cap":{"nodes":{"Sys.Modify":1,"Sys.PowerMgmt":1,"Sys.Audit":1,"Sys.Syslog":1,"Sys.Console":1,"Permissions.Modify":1},"access":{"Permissions.Modify":1,"User.Modify":1,"Group.Allocate":1},"vms":{"VM.Backup":1,"Permissions.Modify":1,"VM.Snapshot":1,"VM.Config.Network":1,"VM.Config.Disk":1,"VM.Clone":1,"VM.Config.CDROM":1,"VM.Monitor":1,"VM.Allocate":1,"VM.Config.Options":1,"VM.Console":1,"VM.Migrate":1,"VM.Snapshot.Rollback":1,"VM.PowerMgmt":1,"VM.Audit":1,"VM.Config.CPU":1,"VM.Config.Memory":1,"VM.Config.HWType":1},"storage":{"Permissions.Modify":1,"Datastore.Audit":1,"Datastore.Allocate":1,"Datastore.AllocateTemplate":1,"Datastore.AllocateSpace":1},"dc":{"Sys.Audit":1}},"ticket":"PVE:root@pam:5DF8EC22::STV4HNO1wplmsyMDM5s6SUsU4cS7sBBBw+HOCEhSSV+6WGtz3zwIzHqBhq/ziJoBs7NqqyLXG4wn9jXJCMdYht+ndqwxtdFQsUNOF1Q/eTWwcyl+Q1fmPNOIIUoxMY8OqGBVozgIimiAJxdqm+2SJnrPEmlJge6m3yf/OEVAkKFCfRMOtSuyVnIbuLx6h6obvezBUP5+ZHzeTMmmXcH4rOsOKgW9XfwryLHbkjjq9Ennx0xjQaBD9Bo5ERquY0hNmWcdPC/p7ZzILTr4xH9sJe9Na2z6GhgJyTgOCAMengyIegySMq7IKIkmsp8odF4/iIC3005/XLF4w/DjPYQUMA=="}}',
          200);
      expect(
          handleAccessTicketResponse(response, "root", dummyEndpoint),
          isA<Credentials>()
              .having((e) => e.ticket, 'Ticket', ticket)
              .having((e) => e.csrfToken, "CSRF Token", csrfToken)
              .having(
                  (e) => e.expiration,
                  "Token expiration time",
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse("5DF8EC22", radix: 16) * 1000)));
    });
  });
}
