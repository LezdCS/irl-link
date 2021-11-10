import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/data/entities/twitch_dto.dart';
import 'package:irllink/src/domain/entities/twitch.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TwitchRepositoryImpl extends TwitchRepository {
  @override
  Future<DataState<Twitch>> getTwitchFromLocal() async {
    final box = GetStorage();
    var twitchDataString = box.read('twitchData');
    if (twitchDataString != null) {
      Map<String, dynamic> twitchDataJson = jsonDecode(twitchDataString);
      Twitch twitchData = TwitchDTO.fromJson(twitchDataJson);
      return DataSuccess(twitchData);
    } else {
      return DataFailed(throw new Exception("No Twitch Data in local storage"));
    }
  }

  @override
  Future<DataState<Twitch>> getTwitchOauth(TwitchRequestParams params) async {
    final box = GetStorage();
    try {
      final url = Uri.https(kTwitchAuthUrlBase, kTwitchAuthUrlPath, {
        'client_id': params.clientId,
        'redirect_uri': params.redirectUri,
        'response_type': params.responseType,
        'scope': params.scopes,
        'force_verify': params.forceVerify,
        'claims': params.claims
      });

      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: kRedirectScheme,
        preferEphemeral: true,
      );

      final accessToken = Uri.parse(result).queryParameters['access_token'];
      final idToken = Uri.parse(result).queryParameters['id_token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh_token'];

      Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);

      final twitchData = TwitchDTO(
        accessToken: accessToken!,
        idToken: idToken,
        refreshToken: refreshToken!,
        preferredUsername: decodedToken['preferred_username'],
      );

      String jsonTwitchData = jsonEncode(twitchData);
      box.write('twitchData', jsonTwitchData);

      return DataSuccess(twitchData);
    } catch (e) {
      return DataFailed(
          throw new Exception("Unable to retrieve Twitch Data from Auth"));
    }
  }

  @override
  Future<DataState<String>> logout() async {
    final box = GetStorage();
    box.remove('twitchData');
    return DataSuccess('Correctly Deleted');
  }
}
