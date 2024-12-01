import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsDisconnectUseCase
    implements UseCase<Either<Failure, void>, String> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsDisconnectUseCase({required this.streamelementsRepository});

  @override
  Future<Either<Failure, void>> call({required String params}) {
    return streamelementsRepository.disconnect(params);
  }
}
