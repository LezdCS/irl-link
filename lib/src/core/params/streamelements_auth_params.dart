import 'package:irllink/src/core/utils/constants.dart';

class StreamelementsAuthParams {
  final String clientId;
  final String redirectUri;
  final String responseType;
  final String scopes;

  const StreamelementsAuthParams({
    this.clientId = kStreamelementsAuthClientId,
    this.redirectUri = 'https://irllink.com/api/streamelements/auth',
    this.responseType = 'code',
    this.scopes = 'tips:read '
        'activities:read '
        'loyalty:read '
        'overlays:read '
        'store:read '
        'bot:read '
        'session:read '
        'contest:read '
        'giveaway:read ',
  });
}
