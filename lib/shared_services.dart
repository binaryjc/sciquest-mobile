import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class SharedService {
  final LocalStorage storage = new LocalStorage('gpass_app');

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("login_details") == true ? true : false;
  }

  static Future<bool> setLoginDetailsV2(String? loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    if (loginResponse == null) {
      return prefs.setBool("login_details", false);
    } else {
      return prefs.setBool("login_details", true);
    }
  }

  static Future<void> logout() async {
    //final prefs = await SharedPreferences.getInstance();
    await setLoginDetailsV2(null);
  }
}
