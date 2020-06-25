import 'dart:async';

import 'package:flutter/services.dart';

class Alibaichuan {
  static const MethodChannel _channel =
      const MethodChannel('alibaichuan');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> get init async {
    final Map<dynamic,dynamic>  res = await _channel.invokeMethod('init');

    return res;
  }
  static Future<Map<dynamic,dynamic>> get login async {
    final Map<dynamic,dynamic> res = await _channel.invokeMethod('login');

    return res;
  }
  static Future<Map<dynamic,dynamic>> get logout async {
    final Map<dynamic,dynamic> res = await _channel.invokeMethod('logout');

    return res;
  }
  static Future<Map<dynamic,dynamic>>  openUrl(String url) async {
    final Map<dynamic,dynamic> res = await _channel.invokeMethod('openUrl',{'url':url});
    return res;
  }
}
