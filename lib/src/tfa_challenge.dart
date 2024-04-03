class TfaChallenge {
  final bool totp;

  final List<int?> recovery;

  final Object? webauthn;

  final bool yubico;

  final bool legacyTfaPath;

  TfaChallenge({
    this.totp = false,
    List<int>? recovery = null,
    this.webauthn = null,
    this.yubico = false,
    this.legacyTfaPath = false,
  }) : recovery = recovery ?? [];

  factory TfaChallenge.fromJson(Map<String, dynamic> json) {
    return TfaChallenge(
      totp: json['totp'] ?? false,
      recovery: json['recovery']?.cast<int>(),
      webauthn: json['webauthn'],
      yubico: json['yubico'] ?? false,
      legacyTfaPath: false,
    );
  }

  factory TfaChallenge.legacy() {
    return TfaChallenge(
      totp: true,
      recovery: null,
      webauthn: null,
      yubico: false,
      legacyTfaPath: true,
    );
  }

  bool hasRecovery() {
    return recovery.any((e) => e != null);
  }

  Iterable<String> kinds() sync* {
    if (totp) yield "totp";
    if (hasRecovery()) yield "recovery";
    // FIXME: we currently don't support webauthn so we ignore it
    if (yubico) yield "yubico";
  }
}
