import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:collection/collection.dart';
import 'package:irllink/src/presentation/widgets/chat_message/cheer_emote.dart';
import 'package:irllink/src/presentation/widgets/chat_message/third_part_emote.dart';
import 'package:irllink/src/presentation/widgets/chat_message/twitch_emote.dart';
import 'package:irllink/src/presentation/widgets/chat_message/word.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';
import '../emote.dart';

enum HighlightType {
  firstTimeChatter,
  subscription,
  subscriptionGifted,
  bitDonation,
  raid,
  channelPointRedemption,
  announcement,
  shoutout,
}

//ignore: must_be_immutable
class TwitchChatMessage {
  final String messageId;
  final List<TwitchBadge> badges;
  final String color;
  final String authorName;
  final String authorId;
  final Map<String, List> emotes;
  final String message;
  final List<Widget> messageWidgetsBuild;
  final int timestamp;
  final HighlightType? highlightType;
  final int bitAmount;
  final bool isAction;
  bool isDeleted;

  TwitchChatMessage({
    required this.messageId,
    required this.badges,
    required this.color,
    required this.authorName,
    required this.authorId,
    required this.emotes,
    required this.message,
    required this.messageWidgetsBuild,
    required this.timestamp,
    required this.highlightType,
    required this.bitAmount,
    required this.isAction,
    required this.isDeleted,
  });

  factory TwitchChatMessage.randomGeneration() {
    Uuid uuid = Uuid();
    String username = faker.internet.userName();
    String message = faker.lorem.sentence();
    String color = randomUsernameColor(username);

    List<HighlightType> types = List.from(HighlightType.values);

    Random random = Random();
    HighlightType? highlightType;
        // random.nextInt(10) < 5 ? types[random.nextInt(types.length)] : null;

    List<Widget> messageInWidgets = messageToWidgets(
      messageString: message,
      emotesIdsPositions: {},
      thirdPartEmotes: [],
      settings: Settings.defaultSettings(),
      highlightType: highlightType,
      cheerEmotes: [],
      isAction: false,
      color: color,
    );
    return TwitchChatMessage(
      messageId: uuid.v4(),
      badges: [],
      color: color,
      authorName: username,
      authorId: uuid.v4(),
      emotes: {},
      message: message,
      messageWidgetsBuild: messageInWidgets,
      timestamp: faker.date
          .dateTime(minYear: 2000, maxYear: 2020)
          .microsecondsSinceEpoch,
      highlightType: highlightType,
      bitAmount: 0,
      isAction: false,
      isDeleted: false,
    );
  }

  factory TwitchChatMessage.fromString({
    required List<TwitchBadge> twitchBadges,
    required List<Emote> cheerEmotes,
    required List<Emote> thirdPartEmotes,
    required String message,
    required Settings settings,
  }) {
    final Map<String, String> messageMapped = {};

    List messageSplited = message.split(';');
    messageSplited.forEach((element) {
      List elementSplited = element.split('=');
      messageMapped[elementSplited[0]] = elementSplited[1];
    });

    List<TwitchBadge> badges =
        getBadges(messageMapped['badges'].toString(), twitchBadges);

    String color = messageMapped['color']!;
    if (color == "") {
      color = randomUsernameColor(messageMapped['display-name']!);
    }

    Map<String, List<List<String>>> emotesIdsPositions =
        parseEmotes(messageMapped);

    HighlightType? highlightType;
    //We check if the message is a bit donation
    if (messageMapped['bits'] != null) {
      highlightType = HighlightType.bitDonation;
    } else if (messageMapped["custom-reward-id"] != null) {
      highlightType = HighlightType.channelPointRedemption;
    }
    if (messageMapped["first-msg"] == "1") {
      highlightType = HighlightType.firstTimeChatter;
    }
    if (messageMapped["msg-id"] == "announcement") {
      highlightType = HighlightType.announcement;
    }

    //We get the message wrote by the user
    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    //We check if the message is an action (/me)
    bool isAction = messageString.startsWith("ACTION");
    if (isAction) {
      messageString = messageString
          .replaceFirst("ACTION", '')
          .replaceFirst("", '')
          .trim();
    }

    List<Widget> messageInWidgets = messageToWidgets(
      messageString: messageString,
      emotesIdsPositions: emotesIdsPositions,
      thirdPartEmotes: thirdPartEmotes,
      settings: settings,
      highlightType: highlightType,
      cheerEmotes: cheerEmotes,
      isAction: isAction,
      color: color,
    );

    return TwitchChatMessage(
      messageId: messageMapped['id'] as String,
      badges: badges,
      color: color,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      messageWidgetsBuild: messageInWidgets,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      highlightType: highlightType,
      bitAmount:
          messageMapped['bits'] == null ? 0 : int.parse(messageMapped['bits']!),
      isAction: isAction,
      isDeleted: false,
    );
  }

  static List<TwitchBadge> getBadges(
      String badgesString, List<TwitchBadge> twitchBadges) {
    List<TwitchBadge> badges = <TwitchBadge>[];
    List badgesSplited = badgesString.split(',');
    if (badgesSplited.isNotEmpty) {
      badgesSplited.forEach((i) {
        TwitchBadge? badgeFound = twitchBadges.firstWhereOrNull((badge) =>
            badge.setId == i.split('/')[0] &&
            badge.versionId == i.split('/')[1]);
        if (badgeFound != null) {
          badges.add(badgeFound);
        }
      });
    }
    return badges;
  }

  static String randomUsernameColor(String username) {
    List<List<String>> defaultColors = [
      ["Red", "#FF0000"],
      ["Blue", "#0000FF"],
      ["Green", "#00FF00"],
      ["FireBrick", "#B22222"],
      ["Coral", "#FF7F50"],
      ["YellowGreen", "#9ACD32"],
      ["OrangeRed", "#FF4500"],
      ["SeaGreen", "#2E8B57"],
      ["GoldenRod", "#DAA520"],
      ["Chocolate", "#D2691E"],
      ["CadetBlue", "#5F9EA0"],
      ["DodgerBlue", "#1E90FF"],
      ["HotPink", "#FF69B4"],
      ["BlueViolet", "#8A2BE2"],
      ["SpringGreen", "#00FF7F"]
    ];

    var n = username.codeUnitAt(0) + username.codeUnitAt(username.length - 1);
    return defaultColors[n % defaultColors.length][1];
  }

  static List<Widget> messageToWidgets({
    required String messageString,
    required Map emotesIdsPositions,
    required List thirdPartEmotes,
    required Settings settings,
    HighlightType? highlightType,
    required List cheerEmotes,
    required bool isAction,
    required String color,
  }) {
    List<Widget> messageWidgetsBuild = [];

    for (int i = 0; i < messageString.trim().split(' ').length; i++) {
      String word = messageString.trim().split(' ')[i];

      MapEntry? emote = emotesIdsPositions.entries.firstWhereOrNull((element) =>
          element.value
              .where((position) =>
                  messageString.substring(
                      int.parse(position[0]), int.parse(position[1]) + 1) ==
                  word)
              .isNotEmpty);

      Emote? thirdPartyEmote =
          thirdPartEmotes.firstWhereOrNull((element) => element.name == word);

      if (emote != null) {
        messageWidgetsBuild.add(
          Wrap(
            children: [
              TwitchEmote(
                emote: emote,
              ),
              Text(' '),
            ],
          ),
        );
      } else if (thirdPartyEmote != null) {
        messageWidgetsBuild.add(
          Wrap(
            children: [
              ThirdPartEmote(
                emote: thirdPartyEmote,
              ),
              Text(' '),
            ],
          ),
        );
      } else if (highlightType == HighlightType.bitDonation &&
          cheerEmotes.firstWhereOrNull((emote) => emote.name == word) != null) {
        messageWidgetsBuild.add(
          CheerEmote(
            cheerEmote:
                cheerEmotes.firstWhereOrNull((emote) => emote.name == word)!,
            textSize: settings.textSize!,
          ),
        );
      } else {
        messageWidgetsBuild.add(
          Word(
            word: word,
            isAction: isAction,
            color: color,
            textSize: settings.textSize!,
          ),
        );
      }
    }

    return messageWidgetsBuild;
  }

  static Map<String, List<List<String>>> parseEmotes(
      Map<String, String> messageMapped) {
    Map<String, List<List<String>>> emotesIdsPositions = {};

    List<String> tempEmoteList = [];
    //We get the emotes
    if (messageMapped['emotes'] != "") {
      //We check if there is multiple emotes
      bool multipleEmotes = messageMapped['emotes']!.contains('/');
      //If there is multiple emotes, we split them
      if (multipleEmotes) {
        tempEmoteList = messageMapped['emotes']!.split('/');
      } else {
        tempEmoteList = [messageMapped['emotes']!];
      }

      //We get the emotes positions
      tempEmoteList.forEach((element) {
        List<List<String>> positions = [];
        //We check if there is multiple positions for the same emote
        bool sameEmote = element.split(':')[1].toString().contains(',');
        //If there is multiple positions for the same emote, we split them
        if (sameEmote) {
          for (String position in element.split(':')[1].split(',')) {
            positions.add(position.split('-'));
          }
        } else {
          positions = [element.split(':')[1].split('-')];
        }

        //We add the emote id and the positions to the map
        emotesIdsPositions[element.split(':')[0]] = positions;
      });
    }
    return emotesIdsPositions;
  }
}
