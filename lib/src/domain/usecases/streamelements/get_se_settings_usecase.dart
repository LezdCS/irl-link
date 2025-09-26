import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class GetStreamElementsSettingsUseCase
    implements UseCase<Either<Failure, StreamElementsSettings>, void> {
  final StreamelementsRepository repository;

  GetStreamElementsSettingsUseCase({required this.repository});

  @override
  Future<Either<Failure, StreamElementsSettings>> call({
    void params,
  }) async {
    return repository.getStreamElementsSettings();
  }
}
