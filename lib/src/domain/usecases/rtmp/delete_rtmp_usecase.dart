import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';

class DeleteRtmpUseCase implements UseCase<Either<Failure, void>, int> {
  final RtmpRepository rtmpRepository;

  DeleteRtmpUseCase(this.rtmpRepository);

  @override
  Future<Either<Failure, void>> call({required int params}) {
    return rtmpRepository.deleteRtmp(params);
  }
}
