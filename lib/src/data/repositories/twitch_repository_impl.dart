import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/data/entities/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
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
        profilePicture: decodedToken['picture'],
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

      this
          .getTwitchUser(decodedIdToken.preferredUsername, accessToken!)
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
      return DataFailed(
          throw new Exception("Unable to retrieve Twitch Data from Auth"));
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
        'http://www.irllink.com/twitch/app/refresh-token',
        queryParameters: {'refresh_token': twitchData.refreshToken},
      );

      //todo : faire un copywith une fois freezed mis en place pour le twitchData, ça évite de recréer decoed et user
      TwitchDecodedIdTokenDTO decodedIdToken = TwitchDecodedIdTokenDTO(
        preferredUsername: twitchData.decodedIdToken.preferredUsername,
        profilePicture: twitchData.decodedIdToken.profilePicture,
      );

      TwitchUserDTO twitchUser = TwitchUserDTO(
        profileImageUrl: twitchData.twitchUser.profileImageUrl,
        id: twitchData.twitchUser.id,
        broadcasterType: twitchData.twitchUser.broadcasterType,
        login: twitchData.twitchUser.login,
        description: twitchData.twitchUser.description,
        viewCount: twitchData.twitchUser.viewCount,
        displayName: twitchData.twitchUser.displayName,
      );

      TwitchCredentials newTwitchData = TwitchCredentialsDTO(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        idToken: twitchData.idToken,
        decodedIdToken: decodedIdToken,
        expiresIn: twitchData.expiresIn,
        twitchUser: twitchUser,
      );
      this.setTwitchOnLocal(newTwitchData);
      return DataSuccess(newTwitchData);
    } on DioError catch (e) {
      return DataFailed(throw new Exception("Refresh encountered issues"));
    }
  }

  @override
  Future<DataState<String>> logout() async {
    final box = GetStorage();
    box.remove('twitchData');
    //todo : revoke access token on twitch
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
      this
          .refreshAccessToken(twitchData)
          .then((value) => twitchData = value.data!);

      return DataSuccess(twitchData);
    } else {
      return DataFailed(throw new Exception("No Twitch Data in local storage"));
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
      String username, String accessToken) async {
    Response response;
    var dio = Dio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer ${accessToken}";
      response = await dio.get(
        'https://api.twitch.tv/helix/users',
        queryParameters: {'login': username},
      );
      TwitchUserDTO twitchUser = TwitchUserDTO(
        id: response.data['data'][0]['id'],
        login: response.data['data'][0]['login'],
        displayName: response.data['data'][0]['display_name'],
        broadcasterType: response.data['data'][0]['broadcaster_type'],
        description: response.data['data'][0]['description'],
        profileImageUrl: response.data['data'][0]['profile_image_url'],
        viewCount: response.data['data'][0]['view_count'],
      );

      return DataSuccess(twitchUser);
    } on DioError catch (e) {
      return DataFailed(throw new Exception("Error retrieving user infos"));
    }
  }
}
