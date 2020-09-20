// Flutter imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slashit/src/models/serviceFee.dart';

class PrefManager {
  //===============Daily Streak=========//
  static const String TOKEN = "ACCESSTOKEN";
  static const String NAME = "NAME";
  static const String EMAIL = "EMAIL";
  static const String ROLE = "ROLE";
  static const String AVATAR = "AVATAR";
  static const String USERID = "USERID";
  static const String UNIQUEID = "uniqueId";
  static const String SPENED = "SPENDLIMIT";
  static const String AVAILABLEBALANCE = "AVAILABLEBALANCE";
  static const String DOLLAR = "DOLLAR";
  static const String NGN = "NGN";
  static const String ADDRESS = "ADDRESS";
  static const String STATE = "STATE";
  static const String CITY = "CITY";
  static const String POSTALCODE = "POSTALCODE";
  static const String COUNTRY = "COUNTRY";
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

  int get spendLimit => _getFromDisk(SPENED) ?? null;
  set spendLimit(int value) => _saveToDisk(SPENED, value);

  String get name => _getFromDisk(NAME) ?? null;
  set name(String value) => _saveToDisk(NAME, value);

  String get avatar => _getFromDisk(AVATAR) ?? null;
  set avatar(String value) => _saveToDisk(AVATAR, value);

  String get userID => _getFromDisk(USERID) ?? null;
  set userID(String value) => _saveToDisk(USERID, value);

  String get uniqueId => _getFromDisk(USERID) ?? null;
  set uniqueId(String value) => _saveToDisk(USERID, value);

  num get availableBalance => _getFromDisk(AVAILABLEBALANCE) ?? null;
  set availableBalance(num value) => _saveToDisk(AVAILABLEBALANCE, value);

  ServiceFee get dollar => _getFromDisk(DOLLAR) ?? null;
  set dollar(ServiceFee value) => _saveToDisk(DOLLAR, value);

  ServiceFee get ngn => _getFromDisk(NGN) ?? null;
  set ngn(ServiceFee value) => _saveToDisk(NGN, value);

  //========Shopper Billing Address
  String get address => _getFromDisk(ADDRESS) ?? "null";
  set address(String value) => _saveToDisk(ADDRESS, value);

  String get city => _getFromDisk(CITY) ?? "null";
  set city(String value) => _saveToDisk(CITY, value);

  String get state => _getFromDisk(STATE) ?? "null";
  set state(String value) => _saveToDisk(STATE, value);

  String get postalcode => _getFromDisk(POSTALCODE) ?? "null";
  set postalcode(String value) => _saveToDisk(POSTALCODE, value);

  String get country => _getFromDisk(COUNTRY) ?? "null";
  set country(String value) => _saveToDisk(COUNTRY, value);

  num get exchangeRate => _getFromDisk("EXCHANGERATE") ?? 0;
  set exchangeRate(num value) => _saveToDisk("EXCHANGERATE", value);
//========User Information ==================//

//  int get SIndex => _getFromDisk(SINDEX) ?? 0;
//  set SIndex(int value) => _saveToDisk(SINDEX, value);

//  bool get Sound => _getFromDisk(SOUND) ?? true;
//  set Sound(bool value) => _saveToDisk(SOUND, value);
}
