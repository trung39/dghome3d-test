import 'dart:io';

import 'package:flutter/services.dart';

exitApp() {
  if (Platform.isAndroid) {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  } else if (Platform.isIOS) {
    exit(0);
  }
}