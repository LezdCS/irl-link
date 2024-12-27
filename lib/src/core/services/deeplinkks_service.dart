import 'package:app_links/app_links.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DeeplinksService {
  final AppLinks appLinks;
  final Talker talker;

  DeeplinksService({
    required this.appLinks,
    required this.talker,
  });

  Future<DeeplinksService> init() async {
    appLinks.uriLinkStream.listen((uri) {
      handleDeeplink(uri);
    });
    return this;
  }

  void handleDeeplink(Uri uri) {
    talker.info('uri: $uri');
  }
}
