import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/rtmp_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class RtmpLocalDataSource {
  Future<List<RtmpDTO>> getRtmpList();
  Future<RtmpDTO?> getRtmpById(int id);
  Future<int> addRtmp(RtmpDTO rtmp);
  Future<void> updateRtmp(RtmpDTO rtmp);
  Future<void> deleteRtmp(int id);
}

class RtmpLocalDataSourceImpl implements RtmpLocalDataSource {
  final Talker talker;
  final Database _database;

  RtmpLocalDataSourceImpl({
    required this.talker,
    required Database database,
  }) : _database = database;

  @override
  Future<List<RtmpDTO>> getRtmpList() async {
    talker.logCustom(RtmpLog('Retrieving RTMP list from database.'));

    final List<Map<String, dynamic>> maps = await _database.query('rtmp');

    return List.generate(maps.length, (i) {
      return RtmpDTO(
        id: maps[i]['id'],
        name: maps[i]['name'],
        url: maps[i]['url'],
        key: maps[i]['key'],
        createdAt: DateTime.parse(maps[i]['created_at']),
      );
    });
  }

  @override
  Future<RtmpDTO?> getRtmpById(int id) async {
    talker.logCustom(RtmpLog('Retrieving RTMP with id $id from database.'));

    final List<Map<String, dynamic>> maps = await _database.query(
      'rtmp',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      talker.info('No RTMP found with id $id.');
      return null;
    }

    return RtmpDTO(
      id: maps[0]['id'],
      name: maps[0]['name'],
      url: maps[0]['url'],
      key: maps[0]['key'],
      createdAt: DateTime.parse(maps[0]['created_at']),
    );
  }

  @override
  Future<int> addRtmp(RtmpDTO rtmp) async {
    talker.logCustom(RtmpLog('Adding new RTMP to database.'));

    return _database.insert(
      'rtmp',
      {
        'name': rtmp.name,
        'url': rtmp.url,
        'key': rtmp.key,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateRtmp(RtmpDTO rtmp) async {
    talker.logCustom(RtmpLog('Updating RTMP with id ${rtmp.id} in database.'));

    await _database.update(
      'rtmp',
      {
        'name': rtmp.name,
        'url': rtmp.url,
        'key': rtmp.key,
      },
      where: 'id = ?',
      whereArgs: [rtmp.id],
    );
  }

  @override
  Future<void> deleteRtmp(int id) async {
    talker.logCustom(RtmpLog('Deleting RTMP with id $id from database.'));

    await _database.delete(
      'rtmp',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
