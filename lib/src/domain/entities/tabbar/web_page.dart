import 'package:irllink/src/domain/entities/tabbar/tab_element.dart';

class WebPage extends TabElement {
  late final String pageTitle;
  late final String url;
  late final bool enabled;

  WebPage(
    this.pageTitle,
    this.url,
    this.enabled,
  ) : super(pageTitle);
}
