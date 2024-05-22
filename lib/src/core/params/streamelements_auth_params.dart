import 'package:irllink/src/core/utils/constants.dart';

class StreamelementsAuthParams {
  final String clientId;
  final String redirectUri;
  final String responseType;
  final String scopes;

  const StreamelementsAuthParams({
    this.clientId = kStreamelementsAuthClientId,
    this.redirectUri = 'https://www.irllink.com/api/streamelements/auth',
    this.responseType = 'code',
    this.scopes = 'channel:read tips:read activities:read overlays:read',
  });
}
