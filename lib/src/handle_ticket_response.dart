import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'package:proxmox_dart_api_client/src/extentions.dart';
import 'package:proxmox_dart_api_client/src/tfa_challenge.dart';

Credentials handleAccessTicketResponse(
    http.Response response, Credentials unauthenicatedCredentials) {
  response.validate(false);

  final bodyJson = jsonDecode(response.body)['data'];

  final ticket = bodyJson['ticket'];

  final csrfToken = bodyJson['CSRFPreventionToken'];

  final ticketRegex = RegExp(r'(PVE|PMG)(?:QUAR)?:(?:(\S+):)?([A-Z0-9]{8})::')
      .firstMatch(bodyJson['ticket'])!;

  final time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(ticketRegex.group(3)!, radix: 16) * 1000);

  TfaChallenge? tfa;
  if (ticket.startsWith('PVE:!tfa!')) {
    tfa = TfaChallenge.fromJson(
        jsonDecode(Uri.decodeComponent(ticket.substring(9).split(':')[0])));
  } else if (bodyJson['NeedTFA'] != null && bodyJson['NeedTFA'] == 1) {
    tfa = TfaChallenge.legacy();
  }

  return Credentials(
    unauthenicatedCredentials.apiBaseUrl,
    unauthenicatedCredentials.username,
    ticket: ticket,
    csrfToken: csrfToken,
    expiration: time,
    tfa: tfa,
  );
}

Credentials handleTfaChallengeResponse(
    http.Response response, Credentials pendingTfaCredentials) {
  response.validate(false);

  final bodyJson = jsonDecode(response.body)['data'];

  final ticket = bodyJson['ticket'];

  final ticketRegex = RegExp(r'(PVE|PMG)(?:QUAR)?:(?:(\S+):)?([A-Z0-9]{8})::')
      .firstMatch(bodyJson['ticket'])!;

  final time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(ticketRegex.group(3)!, radix: 16) * 1000);

  return Credentials(
    pendingTfaCredentials.apiBaseUrl,
    pendingTfaCredentials.username,
    ticket: ticket,
    csrfToken: pendingTfaCredentials.csrfToken,
    expiration: time,
    tfa: null,
  );
}
