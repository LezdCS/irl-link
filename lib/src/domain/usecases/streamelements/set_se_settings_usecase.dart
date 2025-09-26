import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class SetStreamElementsSettingsUseCase
    implements UseCase<Either<Failure, void>, StreamElementsSettings> {
  final StreamelementsRepository repository;

  SetStreamElementsSettingsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({
    required StreamElementsSettings params,
  }) async {
    return repository.updateStreamElementsSettings(params);
  }
}
