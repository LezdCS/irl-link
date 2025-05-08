import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/datasources/local/rtmp_local_data_source.dart';
import 'package:irllink/src/data/entities/rtmp_dto.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/repositories/rtmp_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RtmpRepositoryImpl implements RtmpRepository {
  final Mappr _mappr;
  final Talker talker;
  final RtmpLocalDataSource _localDataSource;

  RtmpRepositoryImpl({
    required this.talker,
    required RtmpLocalDataSource localDataSource,
  })  : _mappr = Mappr(),
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<Rtmp>>> getRtmpList() async {
    try {
      talker.logCustom(RtmpLog('Retrieving RTMP list.'));
      final rtmpDTOList = await _localDataSource.getRtmpList();
      List<Rtmp> rtmpList = rtmpDTOList
          .map((rtmpDTO) => _mappr.convert<RtmpDTO, Rtmp>(rtmpDTO))
          .toList();
      return Right(rtmpList);
    } catch (e) {
      talker.error('Error retrieving RTMP list: $e');
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Rtmp>> getRtmpById(int id) async {
    try {
      talker.logCustom(RtmpLog('Retrieving RTMP by id: $id'));
      final rtmpDTO = await _localDataSource.getRtmpById(id);
      if (rtmpDTO != null) {
        Rtmp rtmp = _mappr.convert<RtmpDTO, Rtmp>(rtmpDTO);
        return Right(rtmp);
      }
      return Left(NotFoundFailure());
    } catch (e) {
      talker.error('Error retrieving RTMP by id: $e');
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addRtmp(Rtmp rtmp) async {
    try {
      talker.logCustom(RtmpLog('Adding new RTMP.'));
      RtmpDTO rtmpDTO = _mappr.convert<Rtmp, RtmpDTO>(rtmp);
      final id = await _localDataSource.addRtmp(rtmpDTO);
      return Right(id);
    } catch (e) {
      talker.error('Error adding RTMP: $e');
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateRtmp(Rtmp rtmp) async {
    try {
      talker.logCustom(RtmpLog('Updating RTMP with id: ${rtmp.id}'));
      RtmpDTO rtmpDTO = _mappr.convert<Rtmp, RtmpDTO>(rtmp);
      await _localDataSource.updateRtmp(rtmpDTO);
      return const Right(null);
    } catch (e) {
      talker.error('Error updating RTMP: $e');
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRtmp(int id) async {
    try {
      talker.logCustom(RtmpLog('Deleting RTMP with id: $id'));
      await _localDataSource.deleteRtmp(id);
      return const Right(null);
    } catch (e) {
      talker.error('Error deleting RTMP: $e');
      return Left(DatabaseFailure());
    }
  }
}
