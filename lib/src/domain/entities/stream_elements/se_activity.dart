import 'package:flutter/material.dart';

enum ActivityType {
  follow,
  subscription,
  cheer,
  tip,
  raid,
  host,
  unsupported,
}

enum StreamProvider {
  facebook,
  twitch,
  youtube,
}

@immutable
class SeActivity {
  final String id;
  final String channel;
  final String username;
  final ActivityType activityType;
  final StreamProvider provider;
  final String? message;
  final String? amount;
  final String? tier;
  final bool? gifted;
  final String? sender;
  final String? currency;
  final bool? isTest;

  const SeActivity({
    required this.id,
    required this.channel,
    required this.username,
    required this.activityType,
    required this.provider,
    this.message,
    this.amount,
    this.tier,
    this.gifted,
    this.sender,
    this.currency,
    this.isTest,
  });

  static StreamProvider providerFromString(String providerStr) {
    switch (providerStr.toLowerCase()) {
      case 'facebook':
        return StreamProvider.facebook;
      case 'twitch':
        return StreamProvider.twitch;
      case 'youtube':
        return StreamProvider.youtube;
      default:
        return StreamProvider.twitch;
    }
  }

  Map toJsonForWatch() => {
        'id': id,
        'message': message ?? "",
        'text': textFromEnum(),
        'username': username,
        'colors': colorsForEnum().map((Color e) {
          return (e.a.toInt() << 24) |
              (e.r.toInt() << 16) |
              (e.g.toInt() << 8) |
              e.b.toInt();
        }).toList(),
      };

  List<Color> colorsForEnum() {
    List<Color> colors = <Color>[];
    switch (activityType) {
      case ActivityType.follow:
        //background color
        colors.add(const Color(0xFF1B98E0));
        //circle color
        colors.add(const Color(0xFF13293D));
      case ActivityType.subscription:
        //background color
        colors.add(const Color(0xFFA47CED));
        //circle color
        colors.add(const Color(0xFF341D5B));
      case ActivityType.cheer:
        //background color
        colors.add(const Color(0xFF8B52F3));
        //circle color
        colors.add(const Color(0xFF230D4C));
      case ActivityType.tip:
        //background color
        colors.add(const Color(0xFF13C50F));
        //circle color
        colors.add(const Color(0xFF0C250A));
      case ActivityType.raid:
        //background color
        colors.add(const Color(0xFFCE1260));
        //circle color
        colors.add(const Color(0xFF2E0219));
      case ActivityType.host:
        //background color
        colors.add(const Color(0xFFCE1260));
        //circle color
        colors.add(const Color(0xFF2E0219));
      case ActivityType.unsupported:
        //background color
        colors.add(const Color(0xFFA47CED));
        //circle color
        colors.add(const Color(0xFF341D5B));
    }
    return colors;
  }

  String textFromEnum() {
    String s = '';
    switch (activityType) {
      case ActivityType.follow:
        s = "Follow";
      case ActivityType.subscription:
        bool isPrime = tier == "prime";
        bool isGift = gifted ?? false;
        if (isGift) {
          s = 'Got gifted a sub by $sender';
        } else {
          s = 'Subscribed${isPrime ? " with prime" : ""}';
        }
      case ActivityType.cheer:
        s = 'Cheered $amount bits!';
      case ActivityType.tip:
        s = 'Donated $amount\$!';
      case ActivityType.raid:
        s = '$amount Raiders';
      case ActivityType.host:
        s = '$amount Hosted viewers';
      case ActivityType.unsupported:
        s = 'Unsupported event';
    }
    return s;
  }

  Icon getIcon() {
    Icon icon = const Icon(Icons.person);
    switch (activityType) {
      case ActivityType.follow:
        icon = const Icon(
          Icons.person_add,
          size: 18,
        );
      case ActivityType.subscription:
        icon = const Icon(
          Icons.star,
          size: 18,
        );
      case ActivityType.cheer:
        icon = const Icon(
          Icons.toll,
          size: 18,
        );
      case ActivityType.tip:
        icon = const Icon(
          Icons.attach_money,
          size: 18,
        );
      case ActivityType.raid:
        icon = const Icon(
          Icons.diversity_3,
          size: 18,
        );
      case ActivityType.host:
        icon = const Icon(
          Icons.diversity_3,
          size: 18,
        );
      case ActivityType.unsupported:
        icon = const Icon(
          Icons.block,
          size: 18,
        );
    }
    return icon;
  }
}
