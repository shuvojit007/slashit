// Flutter imports:
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  //===============Daily Streak=========//
  static const String TOKEN = "ACCESSTOKEN";
  static const String NAME = "NAME";
  static const String EMAIL = "EMAIL";
  static const String ROLE = "ROLE";
  static const String AVATAR = "AVATAR";
  static const String DailyStreak = "DailyStreak";
  static const String TodayRewared = "TodayRewared";
  static const String TodayRewardShowed = "TodayRewardShowed";
  static const String TodayUsedTime = "TodayUsedTime";
  static const String LastDayUsed = "LastDayUsed";

  static PrefManager _instance;
  static SharedPreferences _preferences;

  static Future<PrefManager> getInstance() async {
    if (_instance == null) {
      _instance = PrefManager();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  void _saveToDisk<T>(String key, T content) {
    //print('(TRACE) PrefManager:_saveToDisk. key: $key value: $content');
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    // print('(TRACE) PrefManager:_getFromDisk. key: $key value: $value');
    return value;
  }

  //========User Information ==================//
  String get token =>
      (_getFromDisk(TOKEN) != null && _getFromDisk(TOKEN) != "null")
          ? 'Bearer ' + _getFromDisk(TOKEN)
          : null;
  set token(String value) => _saveToDisk(TOKEN, value);

  String get email => _getFromDisk(EMAIL) ?? null;
  set email(String value) => _saveToDisk(EMAIL, value);

  String get role => _getFromDisk(ROLE) ?? null;
  set role(String value) => _saveToDisk(ROLE, value);

  String get name => _getFromDisk(NAME) ?? null;
  set name(String value) => _saveToDisk(NAME, value);

  String get avatar => _getFromDisk(AVATAR) ?? null;
  set avatar(String value) => _saveToDisk(AVATAR, value);
//========User Information ==================//

//  int get SIndex => _getFromDisk(SINDEX) ?? 0;
//  set SIndex(int value) => _saveToDisk(SINDEX, value);

//  bool get Sound => _getFromDisk(SOUND) ?? true;
//  set Sound(bool value) => _saveToDisk(SOUND, value);
}
