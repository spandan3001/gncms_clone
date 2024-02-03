// Import necessary packages
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

// Define the repository class for data storage
class AppRepository {
  // Define keys for shared preferences
  static const String currentUser = 'currentUser';
  static const String currentUserModel = 'currentUserModel';

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, String>> getCurrentUserModel() async {
    String data = prefs.getString(currentUserModel) ?? "";
    return json.decode(data) as Map<String, String>;
  }

  Future<bool> setCurrentUserModel(String data) async {
    return await prefs.setString(currentUserModel, data);
  }
}
