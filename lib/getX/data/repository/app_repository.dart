// Import necessary packages
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Define the repository class for data storage
class AppRepository {
  static const String currentUserModel = 'currentUserModel';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>?> getCurrentUserModel() async {
    String data = _prefs.getString(currentUserModel) ?? "";

    return data.isEmpty ? null : json.decode(data);
  }

  Future<bool> setCurrentUserModel(Map<String, dynamic> data) async {
    String str = json.encode(data);
    return await _prefs.setString(currentUserModel, str);
  }

  Future<bool> disposeUser() async {
    return await _prefs.remove(currentUserModel);
  }
}
