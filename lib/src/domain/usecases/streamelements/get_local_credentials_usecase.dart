import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetLocalCredentialsUseCase
    implements UseCase<Either<Failure, SeCredentials>, void> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetLocalCredentialsUseCase({
    required this.streamelementsRepository,
  });

  @override
  Future<Either<Failure, SeCredentials>> call({void params}) {
    return streamelementsRepository.getSeCredentialsFromLocal();
  }
}
