import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';
import 'emote.dart';

//ignore: must_be_immutable
class TwitchChatMessage extends Equatable {
  final String messageId;
  final List<TwitchBadge> badges;
  final String color;
  final String authorName;
  final String authorId;
  final Map<String, List> emotes;
  final String message;
  final List<Widget> messageWidgetsBuild;
  final int timestamp;
  final bool isBitDonation;
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
    required this.isBitDonation,
    required this.bitAmount,
    required this.isAction,
    required this.isDeleted,
  });

  @override
  List<Object?> get props {
    return [
      messageId,
      badges,
      color,
      authorName,
      authorId,
      emotes,
      message,
      messageWidgetsBuild,
      timestamp,
      isBitDonation,
      bitAmount,
      isAction,
      isDeleted,
    ];
  }

  @override
  bool get stringify => true;

  factory TwitchChatMessage.randomGeneration() {
    Uuid uuid = Uuid();
    List<TwitchBadge> badges = [];
    String message = faker.lorem.sentence();
    return TwitchChatMessage(
      messageId: uuid.v4(),
      badges: badges,
      color: "#FF0000",
      authorName: faker.internet.userName(),
      authorId: uuid.v4(),
      emotes: {},
      message: message,
      messageWidgetsBuild: [
        Wrap(children: [Text(message)])
      ],
      timestamp: faker.date
          .dateTime(minYear: 2000, maxYear: 2020)
          .microsecondsSinceEpoch,
      isBitDonation: false,
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

    Map<String, List<List<String>>> emotesIdsPositions = {};
    List<String> tempEmoteList = [];
    if (messageMapped['emotes'] != "") {
      bool multipleEmotes = messageMapped['emotes']!.contains('/');
      if (multipleEmotes) {
        tempEmoteList = messageMapped['emotes']!.split('/');
      } else {
        tempEmoteList = [messageMapped['emotes']!];
      }

      tempEmoteList.forEach((element) {
        List<List<String>> positions = [];
        bool sameEmote = element.split(':')[1].toString().contains(',');
        if (sameEmote) {
          for (String position in element.split(':')[1].split(',')) {
            positions.add(position.split('-'));
          }
        } else {
          positions = [element.split(':')[1].split('-')];
        }

        emotesIdsPositions[element.split(':')[0]] = positions;
      });
    }

    bool isBitDonation = messageMapped['bits'] != null;

    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    bool isAction = messageString.startsWith("ACTION");
    if (isAction) {
      messageString = messageString
          .replaceFirst("ACTION", '')
          .replaceFirst("", '')
          .trim();
    }

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
      bool isNextWordThirdPartEmoteZeroWidth = false;

      if (emote != null || thirdPartyEmote != null) {
        if (i < messageString.trim().split(' ').length - 1) {
          String nextWord = messageString.trim().split(' ')[i + 1];
          var thirdPartEmote = thirdPartEmotes
              .firstWhereOrNull((element) => element.name == nextWord);
          isNextWordThirdPartEmoteZeroWidth =
              thirdPartEmote?.isZeroWidth ?? false;

          if (isNextWordThirdPartEmoteZeroWidth) {
            messageWidgetsBuild.add(Stack(
              children: [
                emote != null
                    ? _twitchEmote(emote)
                    : _thirdPartEmote(thirdPartyEmote!),
                Image(
                  image: NetworkImage(thirdPartEmotes
                      .firstWhereOrNull((element) => element.name == nextWord)!
                      .url1x),
                ),
              ],
            ));
          }
        }
      }

      if (emote != null) {
        if (isNextWordThirdPartEmoteZeroWidth) continue;

        messageWidgetsBuild.add(
          Wrap(children: [
            _twitchEmote(emote),
            Text(' '),
          ]),
        );
      } else if (thirdPartyEmote != null && settings.isEmotes!) {
        if (isNextWordThirdPartEmoteZeroWidth) continue;

        if (thirdPartyEmote.isZeroWidth) {
          if (i > 0) {
            String previousWord = messageString.trim().split(' ')[i - 1];
            bool isPreviousWordEmote = emotesIdsPositions.entries
                    .firstWhereOrNull((element) => element.value
                        .where((position) =>
                            messageString.substring(int.parse(position[0]),
                                int.parse(position[1]) + 1) ==
                            previousWord)
                        .isNotEmpty) !=
                null;
            bool isPreviousWordThirdPartyEmote =
                thirdPartEmotes.firstWhereOrNull(
                        (element) => element.name == previousWord) !=
                    null;
            if (isPreviousWordEmote || isPreviousWordThirdPartyEmote) continue;
          } else if (i != 0) continue;
        }

        messageWidgetsBuild.add(
          Wrap(children: [
            _thirdPartEmote(thirdPartyEmote),
            Text(' '),
          ]),
        );
      } else if (isBitDonation &&
          cheerEmotes.firstWhereOrNull((emote) => emote.name == word) != null) {
        Emote? cheerEmote =
            cheerEmotes.firstWhereOrNull((emote) => emote.name == word);
        messageWidgetsBuild.add(_cheerEmote(cheerEmote!, settings.textSize!));
      } else {
        messageWidgetsBuild.add(
          Text(
            word + " ",
            style: TextStyle(
              color: isAction
                  ? Color(int.parse(color.replaceAll('#', '0xff')))
                  : Theme.of(Get.context!).textTheme.bodyText1!.color,
              fontSize: settings.textSize,
              fontStyle: isAction ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        );
      }
    }

    return TwitchChatMessage(
      messageId: messageMapped['id'] as String,
      badges: badges,
      color: color,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      messageWidgetsBuild: messageWidgetsBuild,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      isBitDonation: isBitDonation,
      bitAmount:
          messageMapped['bits'] == null ? 0 : int.parse(messageMapped['bits']!),
      isAction: isAction,
      isDeleted: false,
    );
  }
}

List<TwitchBadge> getBadges(
    String badgesString, List<TwitchBadge> twitchBadges) {
  List<TwitchBadge> badges = <TwitchBadge>[];
  List badgesSplited = badgesString.split(',');
  if (badgesSplited.isNotEmpty) {
    badgesSplited.forEach((i) {
      TwitchBadge? badgeFound = twitchBadges.firstWhereOrNull((badge) =>
          badge.setId == i.split('/')[0] && badge.versionId == i.split('/')[1]);
      if (badgeFound != null) {
        badges.add(badgeFound);
      }
    });
  }
  return badges;
}

String randomUsernameColor(String username) {
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

Widget _cheerEmote(Emote cheerEmote, double textSize) {
  return Wrap(children: [
    Image(
      image: NetworkImage(cheerEmote.url1x),
    ),
    Text(
      cheerEmote.id + ' ',
      style: TextStyle(
        color: Color(int.parse(cheerEmote.color!.replaceAll('#', '0xff'))),
        fontSize: textSize,
      ),
    ),
  ]);
}

Widget _thirdPartEmote(Emote emote) {
  return Image(
    image: NetworkImage(emote.url1x),
  );
}

Widget _twitchEmote(MapEntry emote) {
  return Image(
    image: NetworkImage("https://static-cdn.jtvnw.net/emoticons/v2/" +
        emote.key +
        "/default/dark/1.0"),
  );
}
