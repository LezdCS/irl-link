import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:uuid/uuid.dart';

class BrowserTabSettingsDTO extends BrowserTabSettings {
  const BrowserTabSettingsDTO({
    required super.tabs,
  });

  @override
  Map toJson() => {
        'tabs': tabs.map((e) => e.toJson()).toList(),
      };

  factory BrowserTabSettingsDTO.fromJson(Map<String, dynamic> map) {
    return BrowserTabSettingsDTO(
      tabs: (map['tabs'] ?? []).map((e) => BrowserTabDTO.fromJson(e)).toList(),
    );
  }
}

class BrowserTabDTO extends BrowserTab {
  const BrowserTabDTO({
    required super.id,
    required super.title,
    required super.url,
    required super.toggled,
    required super.iOSAudioSource,
  });

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'url': url,
        'toggled': toggled,
        'iOSAudioSource': iOSAudioSource,
      };

  factory BrowserTabDTO.fromJson(Map<String, dynamic> map) {
    var uuid = const Uuid();

    return BrowserTabDTO(
      id: map['id'] ?? uuid.v4(),
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      toggled: map['toggled'] ?? true,
      iOSAudioSource: map['iOSAudioSource'] ?? false,
    );
  }
}
