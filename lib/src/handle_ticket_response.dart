import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';
Credentials handleAccessTicketResponse(
    http.Response response, String username, Uri ticketEndpoint, DateTime startTime) {
  if (response.statusCode != 200) {
    // TODO handle status codes != 200
    throw "State not handled";
  }

  final bodyJson = jsonDecode(response.body)['data'];
  final ticket = bodyJson['ticket'];
  final csrfToken = bodyJson['CSRFPreventionToken'];
  final ticketRegex =
      RegExp(r"PVE:(?:(\S+):)?([A-Z0-9]{8})").firstMatch(bodyJson['ticket']);
  final time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(ticketRegex.group(2), radix: 16) * 1000);
  storeTicket(ticket);
  return Credentials(ticketEndpoint, username,
      ticket: ticket, csrfToken: csrfToken, expiration: time);
}
