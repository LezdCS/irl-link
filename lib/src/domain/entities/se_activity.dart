import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ActivityType {
  follow,
  subscription,
  cheer,
  tip,
  raid,
  host,
  merch,
}

class SeActivity extends Equatable {
  final String id;
  final String username;
  final String message;
  final String? amount;
  final String? soundUrl;
  final ActivityType activityType;

  const SeActivity({
    required this.id,
    required this.username,
    required this.message,
    required this.amount,
    required this.soundUrl,
    required this.activityType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      message,
      amount,
      soundUrl,
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
        colors.add(Color(0xFF6441A5));
        break;
      case ActivityType.cheer:
        //background color
        colors.add(Color(0xFF00698B));
        //circle color
        colors.add(Color(0xFF003B36));
        break;
      case ActivityType.tip:
        //background color
        colors.add(Color(0xFF8D818C));
        //circle color
        colors.add(Color(0xFFB4B8C5));
        break;
      case ActivityType.raid:
        //background color
        colors.add(Color(0xFF149911));
        //circle color
        colors.add(Color(0xFF256D1B));
        break;
      case ActivityType.host:
        //background color
        colors.add(Color(0xFF4A001F));
        //circle color
        colors.add(Color(0xFF2E0219));
        break;
      case ActivityType.merch:
        //background color
        colors.add(Color(0xFF4F5D75));
        //circle color
        colors.add(Color(0xFF2D3142));
        break;
    }
    return colors;
  }

  String textFromEnum() {
    String s = '';
    switch (this.activityType) {
      case ActivityType.follow:
        s = " just followed!";
        break;
      case ActivityType.subscription:
        //todo : if is prime add (prime) after "subscribed"
        s = ' subscribed!';
        break;
      case ActivityType.cheer:
        s = ' sent ${this.amount} bits!';
        break;
      case ActivityType.tip:
        s = ' donated ${this.amount}\$!';
        break;
      case ActivityType.raid:
        s = ' is raiding with ${this.amount} viewers!';
        break;
      case ActivityType.host:
        s = ' is hosting with ${this.amount} viewers!';
        break;
      case ActivityType.merch:
        s = ' bought for ${this.amount}\$ of merch!';
        break;
    }
    return s;
  }
}
