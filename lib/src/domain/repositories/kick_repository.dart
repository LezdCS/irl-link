import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';
import 'package:irllink/src/domain/entities/kick/kick_channel.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/kick/kick_user.dart';
import 'package:irllink/src/domain/usecases/kick/patch_kick_channel_usecase.dart';

abstract class KickRepository {
  Future<Either<Failure, KickCredentials>> getKickOauth(
    KickAuthParams params,
  );

  Future<Either<Failure, KickCredentials>> refreshAccessToken(
    KickCredentials kickData,
  );

  Future<Either<Failure, KickCredentials>> getKickFromLocal();

  Future<Either<Failure, void>> logout(
    String accessToken,
  );

  Future<Either<Failure, KickUser>> getKickUser(
    String accessToken,
  );

  Future<Either<Failure, List<KickCategory>>> getCategories({
    String? searchQuery,
    int? page,
  });

  Future<Either<Failure, List<KickChannel>>> getChannels({
    required String accessToken,
  });

  Future<Either<Failure, KickChannel>> patchChannel(
    PatchKickChannelParams params,
  );
}
