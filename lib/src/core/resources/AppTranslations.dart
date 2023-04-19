import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const List<Map<String, String>> supportedLanguages = [
  {"name":"English","languageCode":"en", "countryCode":"US"},
  {"name":"Français ","languageCode":"fr", "countryCode":"FR"},
];

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initLanguages() async {
    final _keys = await readJson();
    Get.clearTranslations();
    Get.addTranslations(_keys);
  }

  static Future<Map<String, Map<String, String>>> readJson() async {
    final keys = Map<String, Map<String, String>>();

    await Future.forEach(supportedLanguages, (element) async {
      String key = element['languageCode']! + '_' + element['countryCode']!;
      final res = await rootBundle.loadString('./lib/assets/i18n/$key.json');
      Map<String, String> data = Map.castFrom(jsonDecode(res));
      keys.addAll({key: data});
    });
    return keys;
  }
}