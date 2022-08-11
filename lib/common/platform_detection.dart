import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformDetector {
  static const web = 'web';
  static const ios = 'ios';
  static const android = 'android';
  static const fuchsia = 'fuchsia';
  static const linux = 'linux';
  static const macOS = 'macOS';
  static const windows = 'windows';
  static const unknown = 'unknown';

  static String getPlatform() {
    if (kIsWeb) {
      return web;
    }
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else if (Platform.isFuchsia) {
      return fuchsia;
    } else if (Platform.isLinux) {
      return linux;
    } else if (Platform.isMacOS) {
      return macOS;
    } else if (Platform.isWindows) {
      return windows;
    }
    return unknown;
  }

  static T getPlatformValue<T>(
    Map<String, T> values,
    T defaultValue,
  ) {
    return values[getPlatform()] ?? defaultValue;
  }
}
