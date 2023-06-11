import 'package:equatable/equatable.dart';

class ChatSettings extends Equatable {
  final List chatsJoined;
  final bool joinMyself;

  const ChatSettings({
    required this.chatsJoined,
    required this.joinMyself,
  });

  @override
  List<Object?> get props {
    return [
      chatsJoined,
      joinMyself,
    ];
  }

  Map toJson() => {
        'chatsJoined': chatsJoined,
        'joinMyself': joinMyself,
      };

  @override
  bool get stringify => true;

  ChatSettings copyWith({
    List? chatsJoined,
    bool? joinMyself,
  }) {
    return ChatSettings(
      chatsJoined: chatsJoined ?? this.chatsJoined,
      joinMyself: joinMyself ?? this.joinMyself,
    );
  }
}
