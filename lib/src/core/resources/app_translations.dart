import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

const List<Map<String, String>> supportedLanguages = [
  {"name": "English", "languageCode": "en", "countryCode": "US"},
  {"name": "Français ", "languageCode": "fr", "countryCode": "FR"},
  {"name": "繁體中文", "languageCode": "zh", "countryCode": "TW"},
  {"name": "Español", "languageCode": "es", "countryCode": "ES"},
  {"name": "Italiano", "languageCode": "it", "countryCode": "IT"},
];

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initLanguages() async {
    final keys = await readJson();
    Get.clearTranslations();
    Get.addTranslations(keys);
  }

  static Future<Map<String, Map<String, String>>> readJson() async {
    final keys = <String, Map<String, String>>{};

    await Future.forEach(supportedLanguages, (element) async {
      String key = '${element['languageCode']!}_${element['countryCode']!}';
      final res = await rootBundle.loadString('./lib/assets/i18n/$key.json');
      Map<String, String> data = Map.castFrom(jsonDecode(res));
      keys.addAll({key: data});
    });
    return keys;
  }
}
