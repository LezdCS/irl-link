import 'package:equatable/equatable.dart';

class ChatSettings extends Equatable {
  final List chatsJoined;
  final bool joinMyself;
  final bool hideDeletedMessages;

  const ChatSettings({
    required this.chatsJoined,
    required this.joinMyself,
    required this.hideDeletedMessages,
  });

  @override
  List<Object?> get props {
    return [
      chatsJoined,
      joinMyself,
      hideDeletedMessages,
    ];
  }

  Map toJson() => {
        'chatsJoined': chatsJoined,
        'joinMyself': joinMyself,
        'hideDeletedMessages': hideDeletedMessages,
      };

  @override
  bool get stringify => true;

  ChatSettings copyWith({
    List? chatsJoined,
    bool? joinMyself,
    bool? hideDeletedMessages,
  }) {
    return ChatSettings(
      chatsJoined: chatsJoined ?? this.chatsJoined,
      joinMyself: joinMyself ?? this.joinMyself,
      hideDeletedMessages: hideDeletedMessages ?? this.hideDeletedMessages,
    );
  }
}
