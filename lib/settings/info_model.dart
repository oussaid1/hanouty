import 'package:hanouty/components.dart';

class InfoModel {
  PackageInfo packageInfo;
  InfoModel({
    required this.packageInfo,
  });

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;
}
