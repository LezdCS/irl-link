import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/youtube_chat.dart';
import 'package:irllink/src/domain/entities/chat/chat_badge.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/kick/kick_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/badges.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/third_part_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/word.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/cheer_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/twitch_emote.dart';
import 'package:twitch_chat/twitch_chat.dart' hide ChatMessage;

class MessageRow extends StatelessWidget {
  final ChatMessage message;
  final bool displayTimestamp;
  final double textSize;
  final bool hideDeletedMessages;
  final List<ChatEmote> cheerEmotes;
  final List<ChatEmote> thirdPartEmotes;
  final bool showPlatformBadge;

  const MessageRow({
    super.key,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
    required this.hideDeletedMessages,
    required this.cheerEmotes,
    required this.thirdPartEmotes,
    required this.showPlatformBadge,
  });

  @override
  Widget build(BuildContext context) {
    List<ChatBadge> badges = [];
    badges.addAll(message.badgesList);
    if (showPlatformBadge) {
      String badge = '';
      switch (message.platform) {
        case Platform.twitch:
          badge = "lib/assets/twitch/twitch_logo.png";
        case Platform.kick:
          badge = "lib/assets/kick/kickLogo.png";
        case Platform.youtube:
          badge = "lib/assets/youtube/youtubeLogo.png";
      }
      ChatBadge platformBadge = ChatBadge(
        imageUrl1x: badge,
        imageUrl2x: badge,
        imageUrl4x: badge,
        id: '',
      );
      badges.insert(0, platformBadge);
    }

    return Opacity(
      opacity: message.isDeleted && !hideDeletedMessages ? 0.5 : 1,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Visibility(
            visible: displayTimestamp,
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              child: Timestamp(
                timestamp: message.timestamp,
              ),
            ),
          ),
          Badges(
            badges: message.badgesList,
            textSize: textSize,
          ),
          AuthorName(
            isAction: message.isAction,
            username: message.username,
            displayName: message.displayName,
            color: message.color,
            textSize: textSize,
            platform: message.platform,
          ),
          if (message.isDeleted && hideDeletedMessages)
            Text(
              "message_deleted".tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: textSize,
              ),
            )
          else
            for (Widget i in messageContent(
              message,
              null,
              textSize,
              cheerEmotes,
              thirdPartEmotes,
            ))
              i,
        ],
      ),
    );
  }

  List<Widget> messageContent(
    ChatMessage message,
    TwitchChatParameters? params,
    double textSize,
    List<ChatEmote> cheerEmotes,
    List<ChatEmote> thirdPartEmotes,
  ) {
    List<Widget> messageWidgetsBuild = [];
    final List<String> words = message.message.trim().split(' ');

    for (final String word in words) {
      // Handle YouTube emotes first as it's the simplest check
      if (message.platform == Platform.youtube && emojiUrls.containsKey(word)) {
        messageWidgetsBuild.add(_buildYoutubeEmote(emojiUrls[word]!, textSize));
        continue;
      }

      // Check for Twitch emotes
      final emote = _findTwitchEmote(message, word);
      if (emote != null) {
        messageWidgetsBuild.add(_buildTwitchEmoteWidget(emote, textSize));
        continue;
      }

      // Check for third-party emotes
      final thirdPartyEmote = thirdPartEmotes.firstWhereOrNull(
        (element) => element.name == word,
      );
      if (thirdPartyEmote != null) {
        messageWidgetsBuild
            .add(_buildThirdPartyEmoteWidget(thirdPartyEmote, textSize));
        continue;
      }

      // Handle Kick emotes
      if (message.platform == Platform.kick &&
          word.startsWith('[') &&
          word.endsWith(']')) {
        final kickEmoteIds = _extractKickEmoteIds(word);
        if (kickEmoteIds.isNotEmpty) {
          messageWidgetsBuild
              .add(_buildKickEmoteWidget(kickEmoteIds, textSize));
          continue;
        }
      }

      // Handle cheer emotes
      if (message.eventType == EventType.bitDonation) {
        final cheerEmote =
            cheerEmotes.firstWhereOrNull((emote) => emote.name == word);
        if (cheerEmote != null) {
          messageWidgetsBuild.add(_buildCheerEmoteWidget(cheerEmote, textSize));
          continue;
        }
      }

      // Default case: regular word
      messageWidgetsBuild.add(
        Word(
          word: word,
          isAction: message.isAction,
          color: message.color,
          textSize: textSize,
        ),
      );
    }

    return messageWidgetsBuild;
  }

  MapEntry? _findTwitchEmote(ChatMessage message, String word) {
    return message.emotes.entries.firstWhereOrNull(
      (element) => element.value
          .where(
            (position) =>
                message.message.substring(
                  int.parse(position[0]),
                  int.parse(position[1]) + 1,
                ) ==
                word,
          )
          .isNotEmpty,
    );
  }

  List<String> _extractKickEmoteIds(String word) {
    List<String> kickEmoteIds = [];
    final numberOfLeft = '['.allMatches(word).length;
    final numberOfRight = ']'.allMatches(word).length;

    if (numberOfLeft > 1 && numberOfLeft == numberOfRight) {
      // Multiple emotes case: [emote:id:name][emote:id:name]
      final emotesSplit = word.split(']');
      for (final e in emotesSplit) {
        if (e.isEmpty) {
          continue;
        }
        if (':'.allMatches(e).length == 2) {
          final id = e.split(':')[1];
          if (id.isNotEmpty) {
            kickEmoteIds.add(id);
          }
        }
      }
    } else if (':'.allMatches(word).length == 2) {
      // Single emote case: [emote:id:name]
      final id = word.split(':')[1];
      if (id.isNotEmpty) {
        kickEmoteIds.add(id);
      }
    }

    return kickEmoteIds;
  }

  Widget _buildYoutubeEmote(String url, double textSize) {
    return Wrap(
      children: [
        CachedNetworkImage(
          imageUrl: url,
          width: 24,
          height: 24,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ],
    );
  }

  Widget _buildTwitchEmoteWidget(MapEntry emote, double textSize) {
    return Wrap(
      children: [
        TwitchEmote(
          height: textSize,
          emote: emote,
        ),
        const Text(' '),
      ],
    );
  }

  Widget _buildThirdPartyEmoteWidget(ChatEmote emote, double textSize) {
    return Wrap(
      children: [
        ThirdPartEmote(
          emote: emote,
          height: textSize,
        ),
        const Text(' '),
      ],
    );
  }

  Widget _buildKickEmoteWidget(List<String> emoteIds, double textSize) {
    return Wrap(
      children: List.generate(
        emoteIds.length,
        (index) => KickEmote(
          emoteId: emoteIds[index],
          height: textSize,
        ),
      ),
    );
  }

  Widget _buildCheerEmoteWidget(ChatEmote emote, double textSize) {
    return CheerEmote(
      cheerEmote: emote,
      textSize: textSize,
    );
  }
}
