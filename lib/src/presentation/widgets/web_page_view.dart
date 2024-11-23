import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebPageView extends StatefulWidget {
  const WebPageView(this.tab, {super.key});

  final BrowserTab tab;

  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final PlatformWebViewControllerCreationParams params;
  late WebViewController controller;
  RxBool showControls = false.obs;
  Timer? controlsTimer;

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    //create an Uri based on an url that can have a scheme or not
    Uri uri = Uri.parse(widget.tab.url);
    if (uri.scheme.isEmpty) {
      uri = uri.replace(scheme: 'https');
    }

    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(uri);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
            ..add(
              Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
            )
            ..add(
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()
                  ..onDown = (down) {
                    showControls.value = true;
                    controlsTimer?.cancel();
                  }
                  ..onCancel = () async {
                    controlsTimer = Timer.periodic(
                      const Duration(seconds: 4),
                      (Timer t) => showControls.value = false,
                    );
                  },
              ),
            ),
        ),
        Obx(
          () => Visibility(
            visible: showControls.value,
            child: controlPanel(),
          ),
        ),
      ],
    );
  }

  Widget controlPanel() => Container(
        color: context.theme.colorScheme.secondary,
        height: 30,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              child: IconButton(
                onPressed: () async {
                  await controller.goBack();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 35,
              child: IconButton(
                onPressed: () async {
                  await controller.reload();
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 35,
              child: IconButton(
                onPressed: () async {
                  await controller.goForward();
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
}
