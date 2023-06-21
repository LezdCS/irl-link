import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebPageView extends StatefulWidget {
  const WebPageView(this.title, this.url, {super.key});

  final String title;
  final String url;

  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final PlatformWebViewControllerCreationParams params;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: Set(),
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    //create an Uri based on an url that can have a scheme or not
    Uri uri = Uri.parse(widget.url);
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
    return Column(
      children: [
        controlPanel(),
        Expanded(
          child: WebViewWidget(
            controller: controller,
            gestureRecognizers: Set()
              ..add(
                Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
              ),
          ),
        ),
      ],
    );
  }

  Widget controlPanel() {
    return Container(
      color: Colors.black12,
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 35.0,
            child: IconButton(
              onPressed: () {
                controller.goBack();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 35.0,
            child: IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(
                Icons.refresh,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 35.0,
            child: IconButton(
              onPressed: () {
                controller.goForward();
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
}
