import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> getSettings();
  Future<Either<Failure, void>> setSettings(
    Settings settings,
  );

  Future<Either<Failure, void>> addHiddenUser(HiddenUser hiddenUser);
  Future<Either<Failure, void>> removeHiddenUser(HiddenUser hiddenUser);
  Future<Either<Failure, List<HiddenUser>>> getHiddenUsers();

  Future<Either<Failure, void>> addChatGroup(ChatGroup chatGroup);
  Future<Either<Failure, void>> removeChatGroup(ChatGroup chatGroup);
  Future<Either<Failure, void>> addChannel(
    ChatGroup chatGroup,
    Channel channel,
  );
  Future<Either<Failure, void>> removeChannel(
    ChatGroup chatGroup,
    Channel channel,
  );

  Future<Either<Failure, List<ChatGroup>>> getChatGroups();
}
