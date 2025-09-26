import 'package:irllink/src/core/services/youtube_chat.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

/// Utility class for handling platform emotes in chat messages
class EmoteUtils {
  /// Removes all platform emotes from a chat message text
  ///
  /// This function removes:
  /// - Twitch emotes (using position data from emotes map)
  /// - Kick emotes (pattern: [emote:id:name])
  /// - YouTube emotes (from emojiUrls map)
  /// - Third-party emotes (7TV, BTTV, FFZ)
  ///
  /// [message] The chat message containing emote information
  /// [thirdPartEmotes] List of available third-party emotes
  /// Returns the message text with all emotes removed
  static String removeEmotes(
    ChatMessage message,
    List<dynamic> thirdPartEmotes,
  ) {
    String text = message.message;

    if (text.trim().isEmpty) {
      return text;
    }

    // Handle Twitch emotes using position data
    if (message.platform == Platform.twitch && message.emotes.isNotEmpty) {
      text = _removeTwitchEmotes(text, message.emotes);
    }

    // Handle Kick, YouTube and third-party emotes by word matching
    text = _removeWordBasedEmotes(text, message.platform, thirdPartEmotes);

    // Clean up extra spaces
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Removes Twitch emotes using position data from the emotes map
  static String _removeTwitchEmotes(String text, Map<String, List> emotes) {
    // Create a list of all emote positions to remove
    List<List<int>> positionsToRemove = [];

    for (var emotePositions in emotes.values) {
      for (var position in emotePositions) {
        if (position is List && position.length >= 2) {
          int start = int.tryParse(position[0].toString()) ?? -1;
          int end = int.tryParse(position[1].toString()) ?? -1;
          if (start >= 0 && end >= start) {
            positionsToRemove.add([start, end]);
          }
        }
      }
    }

    // Sort positions by start index in descending order to remove from end to start
    positionsToRemove.sort((a, b) => b[0].compareTo(a[0]));

    // Remove emotes from text
    String result = text;
    for (var position in positionsToRemove) {
      int start = position[0];
      int end = position[1] + 1; // End position is inclusive, so add 1

      if (start < result.length && end <= result.length) {
        result = result.substring(0, start) + result.substring(end);
      }
    }

    return result;
  }

  /// Removes word-based emotes (Kick, YouTube, third-party)
  static String _removeWordBasedEmotes(
    String text,
    Platform platform,
    List<dynamic> thirdPartEmotes,
  ) {
    List<String> words = text.split(' ');
    List<String> filteredWords = [];

    for (String word in words) {
      bool isEmote = false;

      // Check for Kick emotes: [emote:id:name] or multiple [emote:id:name][emote:id:name]
      if (platform == Platform.kick && _isKickEmote(word)) {
        isEmote = true;
      }

      // Check for YouTube emotes
      else if (platform == Platform.youtube && emojiUrls.containsKey(word)) {
        isEmote = true;
      }

      // Check for third-party emotes (7TV, BTTV, FFZ, etc.)
      else if (_isThirdPartyEmote(word, thirdPartEmotes)) {
        isEmote = true;
      }

      if (!isEmote) {
        filteredWords.add(word);
      }
    }

    return filteredWords.join(' ');
  }

  /// Checks if a word is a Kick emote
  static bool _isKickEmote(String word) {
    return word.startsWith('[') && word.endsWith(']') && word.contains(':');
  }

  /// Checks if a word is a third-party emote
  static bool _isThirdPartyEmote(String word, List<dynamic> thirdPartEmotes) {
    for (var emote in thirdPartEmotes) {
      if (emote.name == word) {
        return true;
      }
    }
    return false;
  }

  /// Gets the text content of a message without any emotes
  /// This is a convenience method that combines emote removal
  static String getTextOnlyContent(
    ChatMessage message,
    List<dynamic> thirdPartEmotes,
  ) {
    return removeEmotes(message, thirdPartEmotes);
  }
}
