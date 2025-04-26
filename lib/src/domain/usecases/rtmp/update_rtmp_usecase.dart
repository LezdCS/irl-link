import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';

class UpdateRtmpUseCase implements UseCase<Either<Failure, void>, Rtmp> {
  final RtmpRepository rtmpRepository;

  UpdateRtmpUseCase(this.rtmpRepository);

  @override
  Future<Either<Failure, void>> call({required Rtmp params}) {
    return rtmpRepository.updateRtmp(params);
  }
}
