import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  late PackageInfo _packageInfo;

  Future<AppInfoService> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return this;
  }

  String get appName => _packageInfo.appName;
  String get version => _packageInfo.version;
  String get packageName => _packageInfo.packageName;
  String get buildNumber => _packageInfo.buildNumber;
}
