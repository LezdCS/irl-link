import 'package:irllink/src/core/utils/constants.dart';

class KickAuthParams {
  final String clientId;
  final String responseType;
  final String scopes;
  final String forceVerify;
  final String codeChallenge;
  final String codeChallengeMethod;

  const KickAuthParams({
    this.clientId = kKickAuthClientId,
    this.responseType = "code",
    this.scopes = "channel:read tips:read activities:read overlays:read",
    this.forceVerify = "true",
    this.codeChallenge = "OAuth code challenge",
    this.codeChallengeMethod = "S256",
  });
}
