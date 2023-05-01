import 'package:irllink/src/core/utils/constants.dart';

class TwitchAuthParams {
  final String clientId;
  final String redirectUri;
  final String responseType;
  final String scopes;
  final String forceVerify;
  final String claims;

  const TwitchAuthParams({
    this.clientId = kTwitchAuthClientId,
    this.redirectUri = 'https://irllink.com/twitch/app/auth',
    this.responseType = 'code',
    this.scopes = 'openid '
        'channel_editor channel:moderate '
        'chat:read chat:edit '
        'moderator:manage:chat_settings '
        'moderator:manage:banned_users '
        'moderator:manage:chat_messages '
        'channel:manage:broadcast '
        'channel:read:polls channel:manage:polls '
        'channel:read:predictions channel:manage:predictions',
    this.forceVerify = 'true',
    this.claims = '{"userinfo":{"picture":null, "preferred_username":null}}',
  });
}
