import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';

class GetRtmpListUseCase implements UseCase<Either<Failure, List<Rtmp>>, void> {
  final RtmpRepository rtmpRepository;

  GetRtmpListUseCase(this.rtmpRepository);

  @override
  Future<Either<Failure, List<Rtmp>>> call({void params}) {
    return rtmpRepository.getRtmpList();
  }
}
