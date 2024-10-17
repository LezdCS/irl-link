

class BrowserTabSettings {
  final List<BrowserTab> tabs;

  const BrowserTabSettings({
    required this.tabs,
  });

  BrowserTabSettings copyWith({
    List<BrowserTab>? tabs,
  }) {
    return BrowserTabSettings(
      tabs: tabs ?? this.tabs,
    );
  }
}

class BrowserTab {
  final String id;
  final String title;
  final String url;
  final bool toggled;
  final bool iOSAudioSource;

  const BrowserTab({
    required this.id,
    required this.title,
    required this.url,
    required this.toggled,
    required this.iOSAudioSource,
  });

  BrowserTab copyWith({
    String? id,
    String? title,
    String? url,
    bool? toggled,
    bool? iOSAudioSource,
  }) {
    return BrowserTab(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      toggled: toggled ?? this.toggled,
      iOSAudioSource: iOSAudioSource ?? this.iOSAudioSource,
    );
  }
}
