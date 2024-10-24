import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  static final AppInfoService _instance = AppInfoService._internal();
  late PackageInfo _packageInfo;

  factory AppInfoService() {
    return _instance;
  }

  AppInfoService._internal();

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String get appName => _packageInfo.appName;
  String get version => _packageInfo.version;
  String get packageName => _packageInfo.packageName;
  String get buildNumber => _packageInfo.buildNumber;
}
