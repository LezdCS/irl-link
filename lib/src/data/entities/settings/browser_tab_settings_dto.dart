import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:uuid/uuid.dart';

class BrowserTabSettingsDTO extends BrowserTabSettings {
  const BrowserTabSettingsDTO({
    required super.tabs,
  });

  Map toJson() {
    Mappr mappr = Mappr();
    List list = tabs.map((tab) => mappr.convert<BrowserTab, BrowserTabDTO>(tab).toJson()).toList();
    return {
        'tabs': list,
      };
  }

  factory BrowserTabSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<BrowserTab> bDto = [];
    for (dynamic tab in map['tabs'] ?? []) {
      bDto.add(BrowserTabDTO.fromJson(tab));
    }
    return BrowserTabSettingsDTO(
      tabs: bDto,
    );
  }

  factory BrowserTabSettingsDTO.fromList(List<dynamic> list) {
    return BrowserTabSettingsDTO(
      tabs: (list).map((e) => BrowserTabDTO.fromJson(e)).toList(),
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
