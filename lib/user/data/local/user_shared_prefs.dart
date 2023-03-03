import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefsProvider {
  final SharedPreferences prefs;

  UserSharedPrefsProvider(this.prefs);

  void setUserStatus(int userId, bool isLiked) {
    prefs.setBool(userId.toString(), isLiked);
  }
  bool getUserStatus(int userId) {
    return prefs.getBool(userId.toString()) ?? false;
  }
}