import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';

class AddRtmpUseCase implements UseCase<Either<Failure, int>, Rtmp> {
  final RtmpRepository rtmpRepository;

  AddRtmpUseCase(this.rtmpRepository);

  @override
  Future<Either<Failure, int>> call({required Rtmp params}) {
    return rtmpRepository.addRtmp(params);
  }
}
