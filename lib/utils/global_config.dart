import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RokkhiConfig {
  static SharedPreferences pref;

//  gives app fixed orientation of "Portrait view mode"
  void portraitViewOnly() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}