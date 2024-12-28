import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DeeplinksService {
  final AppLinks appLinks;
  final Talker talker;
  StreamSubscription? _subscription;

  DeeplinksService({
    required this.appLinks,
    required this.talker,
  });

  Future<DeeplinksService> init() async {
    talker.info('DeeplinksService init');
    _subscription = appLinks.uriLinkStream.listen((uri) {
      talker.info('uri: $uri');
      handleDeeplink(uri);
    });
    return this;
  }

  void handleDeeplink(Uri uri) {
    talker.info('uri: $uri');
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
