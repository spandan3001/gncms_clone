// Import necessary packages
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Define the repository class for data storage
class AppRepository {
  // Define keys for shared preferences
  static const String currentUser = 'currentUser';
  static const String currentUserModel = 'currentUserModel';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, String>?> getCurrentUserModel() async {
    String data = _prefs.getString(currentUserModel) ?? "";

    return data.isEmpty ? null : json.decode(data) as Map<String, String>;
  }

  Future<bool> setCurrentUserModel(Map<String, String> data) async {
    String str = json.encode(data);
    return await _prefs.setString(currentUserModel, str);
  }
}
