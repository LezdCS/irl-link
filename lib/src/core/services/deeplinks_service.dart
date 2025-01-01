import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

class DeeplinksService {
  final AppLinks appLinks;
  final Talker talker;
  StreamSubscription? _subscription;

  DeeplinksService({
    required this.appLinks,
    required this.talker,
  });

  Future<DeeplinksService> init() async {
    _subscription = appLinks.uriLinkStream.listen(handleDeeplink);
    return this;
  }

  void handleDeeplink(Uri uri) {
    talker.info('uri: $uri');

    // Parse the fragment (part after #)
    final fragment = uri.fragment;
    if (fragment.isEmpty) {
      talker.error('Empty fragment in deeplink: $uri');
      return;
    }

    // Split the fragment into path and query (e.g. /irltools?apiKey=xxx&config=xxx)
    final fragmentParts = fragment.split('?');
    if (fragmentParts.isEmpty) {
      talker.error('Invalid fragment format: $fragment');
      return;
    }

    // Get the service path (e.g. /irltools -> irltools)
    final service = fragmentParts[0].replaceAll('/', '');

    // Parse query parameters if they exist
    final queryParams = fragmentParts.length > 1
        ? Uri.splitQueryString(fragmentParts[1])
        : <String, String>{};

    switch (service) {
      case 'irltools':
        _handleIrlTools(queryParams);
        break;
      default:
        talker.error('Unknown service in deeplink: $service');
    }
  }

  Future<void> _handleIrlTools(Map<String, String> params) async {
    final apiKey = params['apiKey'];
    final config = params['config'];

    if (apiKey == null || config == null) {
      talker.error('Invalid irltools deeplink: missing required parameters');
      return;
    }

    // Get the settings service
    final settingsService = Get.find<SettingsService>();
    final settings = settingsService.settings.value;

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    final baseUrl = remoteConfig.getString('irltools_obs_remote_base_url');

    // Create a new browser tab
    final tab = BrowserTab(
      id: const Uuid().v4(),
      title: 'IRL Tools',
      url: '$baseUrl?apiKey=$apiKey&config=$config',
      toggled: true,
      iOSAudioSource: false,
    );

    // Add the tab to settings
    final tabs = List<BrowserTab>.from(settings.browserTabs.tabs)..add(tab);
    settingsService.settings.value = settings.copyWith(
      browserTabs: settings.browserTabs.copyWith(tabs: tabs),
    );
    settingsService.saveSettings();

    // Apply the settings to update the UI
    Get.find<HomeViewController>().applySettings();
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
