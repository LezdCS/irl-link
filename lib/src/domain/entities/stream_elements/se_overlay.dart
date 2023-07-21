import 'package:equatable/equatable.dart';

class SeOverlay extends Equatable {
  final String id;
  final String name;

  const SeOverlay({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
    ];
  }

  @override
  bool get stringify => true;
}
