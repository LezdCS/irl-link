import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/pkce_utils.dart';
import 'package:uuid/uuid.dart';

class KickAuthParams {
  final String clientId;
  final String responseType;
  final String scopes;
  final String codeChallenge;
  final String codeChallengeMethod;
  final String state;

  const KickAuthParams({
    this.clientId = kKickAuthClientId,
    this.responseType = "code",
    this.scopes =
        "user:read channel:read channel:write chat:write streamkey:read events:subscribe",
    this.codeChallenge = "",
    this.codeChallengeMethod = "S256",
    this.state = "",
  });

  factory KickAuthParams.withPKCE() {
    final codeVerifier = PKCEUtils.generateCodeVerifier();
    final codeChallenge = PKCEUtils.generateCodeChallenge(codeVerifier);
    final state = const Uuid().v4();

    return KickAuthParams(
      codeChallenge: codeChallenge,
      state: state,
    );
  }
}
