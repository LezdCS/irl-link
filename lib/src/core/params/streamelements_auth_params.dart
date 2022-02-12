import 'package:irllink/src/core/utils/constants.dart';

class StreamelementsAuthParams {
  final String clientId;
  final String redirectUri;
  final String responseType;
  final String scopes;

  const StreamelementsAuthParams({
    this.clientId = kStreamelementsAuthClientId,
    this.redirectUri = 'https://irllink.com/streamelements/auth',
    this.responseType = 'code',
    this.scopes = 'activities:read activities:write tips:read',
  });
}
