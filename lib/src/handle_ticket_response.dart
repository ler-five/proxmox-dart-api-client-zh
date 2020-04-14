
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'package:proxmox_dart_api_client/src/extentions.dart';
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';
Future<Credentials> handleAccessTicketResponse (
    http.Response response, String username, Uri ticketEndpoint) async {

  response.validate(false);

  final bodyJson = jsonDecode(response.body)['data'];
  final ticket = bodyJson['ticket'];
  final csrfToken = bodyJson['CSRFPreventionToken'];
  final ticketRegex =
      RegExp(r"(PVE|PMG)(?:QUAR)?:(?:(\S+):)?([A-Z0-9]{8})::").firstMatch(bodyJson['ticket']);
  final time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(ticketRegex.group(3), radix: 16) * 1000);
  storeTicket(ticket, ticketRegex.group(1));
  return Credentials(ticketEndpoint, username,
      ticket: ticket, csrfToken: csrfToken, expiration: time);
}
