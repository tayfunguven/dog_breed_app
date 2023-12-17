import 'dart:io';

class OSInfo {
  static String getOSVersion() {
    if (Platform.isAndroid) {
      String version = Platform.operatingSystemVersion;
      return 'Android $version';
    } else if (Platform.isIOS) {
      String version = Platform.operatingSystemVersion;
      return 'iOS $version';
    } else {
      return 'Unknown OS';
    }
  }
}
