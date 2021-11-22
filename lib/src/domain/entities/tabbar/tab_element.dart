import 'package:irllink/src/domain/entities/tabbar/web_page.dart';

class TabElement {
  late final title;
  TabElement(this.title);

  toWebPage() {
    return this as WebPage;
  }
}
