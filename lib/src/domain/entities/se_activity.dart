import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ActivityType {
  follow,
  subscription,
  cheer,
  tip,
  raid,
  host,
}

class SeActivity extends Equatable {
  final String id;
  final String channel;
  final String username;
  final ActivityType activityType;
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
    this.message,
    this.amount,
    this.tier,
    this.gifted,
    this.sender,
    this.currency,
    this.isTest,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      message,
      amount,
      activityType,
    ];
  }

  @override
  bool get stringify => true;

  List<Color> colorsForEnum() {
    List<Color> colors = <Color>[];
    switch (this.activityType) {
      case ActivityType.follow:
        //background color
        colors.add(Color(0xFF1B98E0));
        //circle color
        colors.add(Color(0xFF13293D));
        break;
      case ActivityType.subscription:
        //background color
        colors.add(Color(0xFFA47CED));
        //circle color
        colors.add(Color(0xFF341D5B));
        break;
      case ActivityType.cheer:
        //background color
        colors.add(Color(0xFF8B52F3));
        //circle color
        colors.add(Color(0xFF230D4C));
        break;
      case ActivityType.tip:
        //background color
        colors.add(Color(0xFF13C50F));
        //circle color
        colors.add(Color(0xFF0C250A));
        break;
      case ActivityType.raid:
        //background color
        colors.add(Color(0xFFCE1260));
        //circle color
        colors.add(Color(0xFF2E0219));
        break;
      case ActivityType.host:
        //background color
        colors.add(Color(0xFFCE1260));
        //circle color
        colors.add(Color(0xFF2E0219));
        break;
    }
    return colors;
  }

  String textFromEnum() {
    String s = '';
    switch (this.activityType) {
      case ActivityType.follow:
        s = "Follow";
        break;
      case ActivityType.subscription:
        bool isPrime = this.tier == "prime";
        bool isGift = this.gifted == true;
        if (isGift) {
          s = 'Got gifted a sub by ${this.sender}';
        } else {
          s = 'Subscribed${isPrime ? " with prime" : ""}';
        }
        break;
      case ActivityType.cheer:
        s = 'Cheered ${this.amount} bits!';
        break;
      case ActivityType.tip:
        s = 'Donated ${this.amount}\$!';
        break;
      case ActivityType.raid:
        s = '${this.amount} Raiders';
        break;
      case ActivityType.host:
        s = '${this.amount} Hosted viewers';
        break;
    }
    return s;
  }

  Icon getIcon() {
    Icon icon = Icon(Icons.person);
    switch (this.activityType) {
      case ActivityType.follow:
        icon = Icon(
          Icons.person_add,
          size: 18,
        );
        break;
      case ActivityType.subscription:
        icon = Icon(
          Icons.star,
          size: 18,
        );
        break;
      case ActivityType.cheer:
        icon = Icon(
          Icons.toll,
          size: 18,
        );
        break;
      case ActivityType.tip:
        icon = Icon(
          Icons.attach_money,
          size: 18,
        );
        break;
      case ActivityType.raid:
        icon = Icon(
          Icons.diversity_3,
          size: 18,
        );
        break;
      case ActivityType.host:
        icon = Icon(
          Icons.diversity_3,
          size: 18,
        );
        break;
    }
    return icon;
  }
}
