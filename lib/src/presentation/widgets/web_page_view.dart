import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageView extends StatefulWidget {
  WebPageView(this.title, this.url);

  final String title;
  final String url;

  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      allowsInlineMediaPlayback: true,
      gestureRecognizers: Set()
      ..add(
        Factory<EagerGestureRecognizer>(
            () => EagerGestureRecognizer()),
      ),
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
    );
  }
}
