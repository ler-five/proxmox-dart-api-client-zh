import 'credentials.dart';

class ExpirationException implements Exception {

  final Credentials credentials;

  ExpirationException(this.credentials);

  String toString() =>
      "Credentials have expired and can't be refreshed.";
}