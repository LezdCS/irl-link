import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:collection/collection.dart';

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

    List<TwitchBadge> badges = <TwitchBadge>[];
    List badgesSplited = messageMapped['badges'].toString().split(',');
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

    String color = messageMapped['color']!;
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
    if (color == "") {
      var n = messageMapped['display-name']!.codeUnitAt(0) +
          messageMapped['display-name']!
              .codeUnitAt(messageMapped['display-name']!.length - 1);
      color = defaultColors[n % defaultColors.length][1];
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
      var emote = emotesIdsPositions.entries.firstWhereOrNull((element) =>
          element.value
              .where((position) =>
                  messageString.substring(
                      int.parse(position[0]), int.parse(position[1]) + 1) ==
                  word)
              .isNotEmpty);

      var thirdPartyEmote =
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
                    ? Image(
                        image: NetworkImage(
                            "https://static-cdn.jtvnw.net/emoticons/v2/" +
                                emote.key +
                                "/default/dark/1.0"),
                      )
                    : Image(
                        image: NetworkImage(thirdPartyEmote!.url1x),
                      ),
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
        if (isNextWordThirdPartEmoteZeroWidth) {
          continue;
        }
        messageWidgetsBuild.add(
          Wrap(children: [
            Image(
              image: NetworkImage("https://static-cdn.jtvnw.net/emoticons/v2/" +
                  emote.key +
                  "/default/dark/1.0"),
            ),
            Text(' '),
          ]),
        );
      } else if (thirdPartyEmote != null && settings.isEmotes!) {
        if (thirdPartyEmote.isZeroWidth) {
          bool isPreviousWordWasAnEmoteOrThirdEmote = false;
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
            isPreviousWordWasAnEmoteOrThirdEmote =
                isPreviousWordEmote || isPreviousWordThirdPartyEmote;
            if (isPreviousWordWasAnEmoteOrThirdEmote) {
              continue;
            }
          } else {
            if (i != 0) {
              continue;
            }
          }
        }

        if (isNextWordThirdPartEmoteZeroWidth) {
          continue;
        }

        messageWidgetsBuild.add(
          Wrap(children: [
            Image(
              image: NetworkImage(thirdPartyEmote.url1x),
            ),
            Text(' '),
          ]),
        );
      } else if (isBitDonation &&
          cheerEmotes.firstWhereOrNull((emote) => emote.name == word) != null) {
        Emote? cheerEmote =
            cheerEmotes.firstWhereOrNull((emote) => emote.name == word);
        messageWidgetsBuild.add(
          Wrap(children: [
            Image(
              image: NetworkImage(cheerEmote!.url1x),
            ),
            Text(
              cheerEmote.id + ' ',
              style: TextStyle(
                color:
                    Color(int.parse(cheerEmote.color!.replaceAll('#', '0xff'))),
                fontSize: settings.textSize,
              ),
            ),
          ]),
        );
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
