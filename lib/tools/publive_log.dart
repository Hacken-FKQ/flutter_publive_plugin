import 'package:flutter/foundation.dart';

class PubLiveLog {
  // ignore: non_constant_identifier_names
  static String TAG = 'PubLive';

  static bool debugAble = kReleaseMode ? false : true;

  static void e(Object object, {String? tag}) {
    _printLog(tag, ' | E | ', object);
  }

  static void v(Object object, {String? tag}) {
    if (debugAble) {
      _printLog(tag, ' | V | ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    StringBuffer sb = StringBuffer();
    sb.write((tag == null || tag.isEmpty) ? TAG : tag);
    sb.write(stag);
    sb.write(object);
    print(sb.toString());
  }
}
