import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;

class HiddenUser {
  final String id;
  final String username;
  final Platform platform;

  HiddenUser({
    required this.id,
    required this.username,
    required this.platform,
  });
}
