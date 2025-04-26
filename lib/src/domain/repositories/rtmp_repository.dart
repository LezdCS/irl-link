import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';

abstract class RtmpRepository {
  Future<Either<Failure, List<Rtmp>>> getRtmpList();
  Future<Either<Failure, Rtmp>> getRtmpById(int id);
  Future<Either<Failure, int>> addRtmp(Rtmp rtmp);
  Future<Either<Failure, void>> updateRtmp(Rtmp rtmp);
  Future<Either<Failure, void>> deleteRtmp(int id);
}
