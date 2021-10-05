class WebPage {
  late final String _title;
  late final String _url;
  late final bool _enabled;

  WebPage(this._title, this._url, this._enabled);

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
