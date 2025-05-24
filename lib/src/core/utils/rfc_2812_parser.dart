/// RFC 2812 IRC Protocol Parser
/// Implementation based on https://www.rfc-editor.org/rfc/rfc2812
library;

class IRCMessage {
  /// The raw tags string from the message (Twitch-specific)
  final String? rawTags;

  /// Parsed message tags as a map (Twitch-specific)
  final Map<String, String> tags;

  final String? prefix;
  final String command;
  final List<String> parameters;
  final String? trailing;

  IRCMessage({
    this.rawTags,
    Map<String, String>? tags,
    this.prefix,
    required this.command,
    required this.parameters,
    this.trailing,
  }) : tags = tags ?? {};

  /// Parse raw tags string into a Map
  static Map<String, String> parseTags(String rawTags) {
    final tags = <String, String>{};
    final tagPairs = rawTags.split(';');

    for (final pair in tagPairs) {
      final parts = pair.split('=');
      if (parts.length == 2) {
        tags[parts[0]] = parts[1];
      } else if (parts.length == 1) {
        tags[parts[0]] = '';
      }
    }

    return tags;
  }

  @override
  String toString() {
    final parts = <String>[];

    if (rawTags != null) {
      parts.add('@$rawTags');
    }

    if (prefix != null) {
      parts.add(':$prefix');
    }

    parts.add(command);

    if (parameters.isNotEmpty) {
      parts.addAll(parameters);
    }

    if (trailing != null) {
      parts.add(':$trailing');
    }

    return parts.join(' ');
  }
}

class RFC2812Parser {
  static final _messageRegex = RegExp(
    r'^(?:@([^ ]+) )?(?::([^ ]+) )?([^ ]+)(?: ([^:][^ ]*(?: [^:][^ ]*)*))?(?: :(.+))?$',
  );

  /// Parses a raw IRC message according to RFC 2812 specifications
  /// with support for Twitch IRC tags
  ///
  /// The message format is:
  /// [@tags] [:prefix] command [params] [:trailing]
  ///
  /// Returns null if the message is invalid
  static IRCMessage? parseMessage(String raw) {
    if (raw.isEmpty) {
      return null;
    }

    final match = _messageRegex.firstMatch(raw.trim());
    if (match == null) {
      return null;
    }

    final rawTags = match.group(1);
    final prefix = match.group(2);
    final command = match.group(3);
    final paramsStr = match.group(4);
    final trailing = match.group(5);

    if (command == null) {
      return null;
    }

    final parameters = <String>[];
    if (paramsStr != null) {
      parameters.addAll(paramsStr.split(' '));
    }

    // For PRIVMSG, the channel is always the first parameter
    if (paramsStr == null && trailing != null && command == 'PRIVMSG') {
      final parts = raw.split(' ');
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].startsWith('#')) {
          parameters.add(parts[i]);
          break;
        }
      }
    }

    return IRCMessage(
      rawTags: rawTags,
      tags: rawTags != null ? IRCMessage.parseTags(rawTags) : null,
      prefix: prefix,
      command: command,
      parameters: parameters,
      trailing: trailing,
    );
  }

  /// Validates if a nickname follows RFC 2812 specifications
  ///
  /// According to RFC 2812, a nickname is:
  /// - 1-9 characters for first position: A-Z, a-z, special chars
  /// - 0-8 characters for remaining: A-Z, a-z, 0-9, special chars
  /// Total max length: 9 characters
  static bool isValidNickname(String nickname) {
    if (nickname.isEmpty || nickname.length > 9) {
      return false;
    }

    final firstChar = nickname[0];
    if (!RegExp(r'^[A-Za-z\[\]\\`_\^\{\|\}]$').hasMatch(firstChar)) {
      return false;
    }

    if (nickname.length > 1) {
      final restOfNick = nickname.substring(1);
      if (!RegExp(r'^[A-Za-z0-9\[\]\\`_\^\{\|\}-]*$').hasMatch(restOfNick)) {
        return false;
      }
    }

    return true;
  }

  /// Validates if a channel name follows RFC 2812 specifications
  ///
  /// Channel names must start with &, #, +, or !
  /// Cannot contain spaces, control G (^G), or commas
  static bool isValidChannelName(String channel) {
    if (channel.isEmpty) {
      return false;
    }

    if (!RegExp('^[&#+!]').hasMatch(channel[0])) {
      return false;
    }

    return !RegExp(r'[\s,\x07]').hasMatch(channel);
  }
}
