import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static final SettingsManager _instance = SettingsManager._internal();
  late SharedPreferences _prefs;

  static SettingsManager get instance => _instance;

  SettingsManager._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get themeMode => _prefs.getString('themeMode') ?? 'light';

  set themeMode(String mode) {
    _prefs.setString('themeMode', mode);
  }
}
