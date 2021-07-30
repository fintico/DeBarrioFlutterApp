import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences.internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences.internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get screen {
    return _prefs.getInt('screen') ?? 0;
  }

  set screen(int value) {
    _prefs.setInt('screen', value);
  }

  get username {
    return _prefs.getString('username') ?? '';
  }

  set username(String value) {
    _prefs.setString('username', value);
  }

  get userId {
    return _prefs.getInt('userId') ?? 0;
  }

  set userId(int value) {
    _prefs.setInt('userId', value);
  }

  get address {
    return _prefs.getString('address') ?? ' ';
  }

  set address(String value) {
    _prefs.setString('address', value);
  }

  get latitude {
    return _prefs.getDouble('latitude') ?? 0;
  }

  set latitude(double value) {
    _prefs.setDouble('latitude', value);
  }

  get longitude {
    return _prefs.getDouble('longitude') ?? 0;
  }

  set longitude(double value) {
    _prefs.setDouble('longitude', value);
  }
}
