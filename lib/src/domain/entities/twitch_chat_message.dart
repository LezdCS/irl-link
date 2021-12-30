import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:collection/collection.dart';

//ignore: must_be_immutable
class TwitchChatMessage extends Equatable {
  //todo : add bool isBitDonation
  final String messageId;
  final List<TwitchBadge> badges;
  final String color;
  final String authorName;
  final String authorId;
  final Map<String, List> emotes;
  final String message;
  final int timestamp;
  final bool isBitDonation;
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
    required this.timestamp,
    required this.isBitDonation,
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
      timestamp,
      isBitDonation,
      isAction,
      isDeleted,
    ];
  }

  @override
  bool get stringify => true;

  factory TwitchChatMessage.fromString(
    List<TwitchBadge> twitchBadges,
    String message,
  ) {
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

    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    bool isAction = messageString.startsWith("ACTION");
    if (isAction) {
      messageString = messageString
          .replaceFirst("ACTION", '')
          .replaceFirst("", '')
          .trim();
    }
    debugPrint(messageString);
    debugPrint(messageString.length.toString());

    return TwitchChatMessage(
      messageId: messageMapped['id'] as String,
      badges: badges,
      color: messageMapped['color'] as String,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      isBitDonation: messageMapped['bits'] != null ? true : false,
      isAction: isAction,
      isDeleted: false,
    );
  }
}
