// lib/utils/shared_preferences_helper.dart
// lib/utils/shared_preferences_helper.dart
// (Assuming your file is actually named 'shared_preferences_helper.dart' as per your AuthService import)

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _authTokenKey = 'auth_token';

  // Save the token to SharedPreferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    print('Token saved locally.'); // Added for debugging
  }

  // Get the token from SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Remove the token from SharedPreferences
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    print('Token removed locally.'); // Added for debugging
  }
}