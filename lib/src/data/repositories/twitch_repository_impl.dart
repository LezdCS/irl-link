import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/data/entities/emote_dto.dart';
import 'package:irllink/src/data/entities/twitch_badge_dto.dart';
import 'package:irllink/src/data/entities/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

//todo : call the token refresh if an api request get an error of access token

class TwitchRepositoryImpl extends TwitchRepository {
  @override
  Future<DataState<TwitchCredentials>> getTwitchOauth(
      TwitchAuthParams params) async {
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
      final expiresIn = Uri.parse(result).queryParameters['expires_in'];

      Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);

      TwitchDecodedIdTokenDTO decodedIdToken = TwitchDecodedIdTokenDTO(
        preferredUsername: decodedToken['preferred_username'],
        profilePicture: decodedToken['picture'] ?? "",
      );

      TwitchUserDTO twitchUser = TwitchUserDTO(
        profileImageUrl: '',
        id: '',
        broadcasterType: '',
        login: '',
        description: '',
        viewCount: '',
        displayName: '',
      );

      await this
          .getTwitchUser(null, accessToken!)
          .then((value) => twitchUser = value.data!);

      final twitchData = TwitchCredentialsDTO(
        accessToken: accessToken,
        idToken: idToken,
        refreshToken: refreshToken!,
        expiresIn: expiresIn!,
        decodedIdToken: decodedIdToken,
        twitchUser: twitchUser,
      );

      //save the twitch credentials on the smartphone
      this.setTwitchOnLocal(twitchData);

      return DataSuccess(twitchData);
    } catch (e) {
      return DataFailed("Unable to retrieve Twitch Data from Auth");
    }
  }

  @override
  Future<DataState<TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  ) async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get(
        'https://www.irllink.com/twitch/app/refresh-token',
        queryParameters: {'refresh_token': twitchData.refreshToken},
      );

      TwitchCredentials newTwitchData = TwitchCredentials(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        idToken: twitchData.idToken,
        decodedIdToken: twitchData.decodedIdToken,
        expiresIn: twitchData.expiresIn,
        twitchUser: twitchData.twitchUser,
      );
      this.setTwitchOnLocal(newTwitchData);

      await this.validateToken(newTwitchData.accessToken);

      debugPrint('token refreshed');
      return DataSuccess(newTwitchData);
    } on DioError catch (e) {
      return DataFailed("Refresh encountered issues");
    }
  }

  Future<void> validateToken(String accessToken) async {
    try {
      Response response;
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get('https://id.twitch.tv/oauth2/validate');
      debugPrint('Token is valid');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  @override
  Future<DataState<String>> logout() async {
    final box = GetStorage();
    box.remove('twitchData');
    //todo : call twitch api revoke access token
    return DataSuccess('Logged out successfuly');
  }

  @override
  Future<DataState<TwitchCredentials>> getTwitchFromLocal() async {
    final box = GetStorage();
    var twitchDataString = box.read('twitchData');
    if (twitchDataString != null) {
      Map<String, dynamic> twitchDataJson = jsonDecode(twitchDataString);

      TwitchCredentials twitchData =
          TwitchCredentialsDTO.fromJson(twitchDataJson);

      //refresh the access token to be sure the token is going to be valid after starting the app
      await this
          .refreshAccessToken(twitchData)
          .then((value) => twitchData = value.data!);

      return DataSuccess(twitchData);
    } else {
      return DataFailed("No Twitch Data in local storage");
    }
  }

  @override
  Future<void> setTwitchOnLocal(TwitchCredentials twitchData) async {
    final box = GetStorage();
    String jsonTwitchData = jsonEncode(twitchData);
    box.write('twitchData', jsonTwitchData);
  }

  @override
  Future<DataState<TwitchUserDTO>> getTwitchUser(
      String? username, String accessToken) async {
    Response response;
    var dio = Dio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      if (username != null) {
        response = await dio.get(
          'https://api.twitch.tv/helix/users',
          queryParameters: {'login': username},
        );
      } else {
        //if no username then it get the user linked to the accessToken
        response = await dio.get(
          'https://api.twitch.tv/helix/users',
        );
      }

      TwitchUserDTO twitchUser =
          TwitchUserDTO.fromJson(response.data['data'][0]);

      return DataSuccess(twitchUser);
    } on DioError catch (e) {
      return DataFailed("Error retrieving user infos");
    }
  }

  @override
  Future<DataState<List<TwitchBadge>>> getTwitchGlobalBadges(
      String accessToken) async {
    Response response;
    var dio = Dio();
    List<TwitchBadge> badges = <TwitchBadge>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response =
          await dio.get('https://api.twitch.tv/helix/chat/badges/global');

      response.data['data'].forEach(
        (set) => set['versions'].forEach((version) =>
            badges.add(TwitchBadgeDTO.fromJson(set['set_id'], version))),
      );

      return DataSuccess(badges);
    } on DioError catch (e) {
      print(e.response);
      return DataFailed("Error retrieving Twitch global badges");
    }
  }

  @override
  Future<DataState<List<TwitchBadge>>> getTwitchChannelBadges(
      String accessToken, String broadcasterId) async {
    Response response;
    var dio = Dio();
    List<TwitchBadge> badges = <TwitchBadge>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get(
          'https://api.twitch.tv/helix/chat/badges?broadcaster_id=$broadcasterId');

      response.data['data'].forEach(
        (set) => set['versions'].forEach((version) =>
            badges.add(TwitchBadgeDTO.fromJson(set['set_id'], version))),
      );

      return DataSuccess(badges);
    } on DioError catch (e) {
      return DataFailed("Error retrieving Twitch broadcaster channel badges");
    }
  }

  @override
  Future<DataState<List<Emote>>> getTwitchEmotes(String accessToken) async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response =
          await dio.get('https://api.twitch.tv/helix/chat/emotes/global');

      response.data['data'].forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJson(emote),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving global emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getTwitchChannelEmotes(
    String accessToken,
    String broadcasterId,
  ) async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get(
        'https://api.twitch.tv/helix/chat/emotes',
        queryParameters: {'broadcaster_id': broadcasterId},
      );

      response.data['data'].forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJson(emote),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving channel emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getTwitchSetsEmotes(
    String accessToken,
    List<String> setId,
  ) async {
    // TODO : max 25 setId per call https://api.twitch.tv/helix/chat/emotes/set?emote_set_id=301590448&emote_set_id=5678
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];

    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      final queryParameters = {'emote_set_id': setId};
      Uri uri = Uri.https(
        "api.twitch.tv",
        "/helix/chat/emotes/set",
        queryParameters,
      );
      response = await dio.getUri(uri);
      response.data['data'].forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJson(emote),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving sets emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getTwitchCheerEmotes(
      String accessToken, String broadcasterId) async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get(
        'https://api.twitch.tv/helix/bits/cheermotes',
        queryParameters: {'broadcaster_id': broadcasterId},
      );

      response.data['data'].forEach(
        (prefix) => prefix['tiers'].forEach(
          (emote) => emotes.add(
            EmoteDTO.fromJsonCheerEmotes(emote, prefix['prefix']),
          ),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving channel cheer emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getFrankerfacezEmotes(
      String broadcasterId) async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      response = await dio.get(
        'https://api.frankerfacez.com/v1/room/id/$broadcasterId',
      );

      response.data['sets'][response.data['sets'].keys.toList()[0]]['emoticons']
          .forEach(
        (emote) => {
          emotes.add(
            EmoteDTO.fromJsonFrankerfacez(emote),
          ),
        }
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving FFZ global emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getBttvChannelEmotes(
      String broadcasterId) async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      response = await dio.get(
        'https://api.betterttv.net/3/cached/users/twitch/$broadcasterId',
      );

      response.data['channelEmotes'].forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJsonBttv(emote),
        ),
      );

      response.data['sharedEmotes'].forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJsonBttv(emote),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving FFZ channel emotes");
    }
  }

  @override
  Future<DataState<List<Emote>>> getBttvGlobalEmotes() async {
    Response response;
    var dio = Dio();
    List<Emote> emotes = <Emote>[];
    try {
      response = await dio.get(
        'https://api.betterttv.net/3/cached/emotes/global',
      );

      response.data.forEach(
        (emote) => emotes.add(
          EmoteDTO.fromJsonBttv(emote),
        ),
      );

      return DataSuccess(emotes);
    } on DioError catch (e) {
      return DataFailed("Error retrieving BTTV Global emotes");
    }
  }

  @override
  Future<DataState<String>> getStreamInfo(String accessToken, String broadcasterId) async {
    Response response;
    var dio = Dio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get(
        'https://api.twitch.tv/helix/streams',
        queryParameters: {'user_id': broadcasterId},
      );

      //debugPrint(response.data.toString());

      return DataSuccess("");
    } on DioError catch (e) {
      return DataFailed("Error Getting Stream Infos");
    }
  }
}
