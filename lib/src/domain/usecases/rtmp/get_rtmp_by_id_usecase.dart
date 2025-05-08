import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';

class GetRtmpByIdUseCase implements UseCase<Either<Failure, Rtmp>, int> {
  final RtmpRepository rtmpRepository;

  GetRtmpByIdUseCase(this.rtmpRepository);

  @override
  Future<Either<Failure, Rtmp>> call({required int params}) {
    return rtmpRepository.getRtmpById(params);
  }
}
