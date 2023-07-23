import 'package:equatable/equatable.dart';

class SeMe extends Equatable {
  final String id;
  final String avatar;
  final String username;
  final String displayName;

  const SeMe({
    required this.id,
    required this.avatar,
    required this.username,
    required this.displayName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      avatar,
      username,
      displayName,
    ];
  }

  @override
  bool get stringify => true;
}
