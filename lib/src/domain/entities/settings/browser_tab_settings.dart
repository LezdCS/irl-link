import 'package:equatable/equatable.dart';

class BrowserTabSettings extends Equatable {
  final List<BrowserTab> tabs;

  const BrowserTabSettings({
    required this.tabs,
  });

  @override
  List<Object?> get props {
    return [
     tabs,
    ];
  }

  Map toJson() => {
        'tabs': tabs.map((e) => e.toJson()).toList(),
      };

  @override
  bool get stringify => true;

  BrowserTabSettings copyWith({
    List<BrowserTab>? tabs,
  }) {
    return BrowserTabSettings(
      tabs: tabs ?? this.tabs,
    );
  }
}


class BrowserTab extends Equatable {
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

  @override
  List<Object?> get props {
    return [
      id,
      title,
      url,
      toggled,
      iOSAudioSource,
    ];
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'url': url,
        'toggled': toggled,
        'iOSAudioSource': iOSAudioSource,
      };

  @override
  bool get stringify => true;

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
