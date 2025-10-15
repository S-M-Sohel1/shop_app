import 'dart:convert';

import 'package:learning_app/commons/models/entities.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  getString(String key) {
    return _pref.getString(key) ?? "";
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(
          AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY,
        ) ??
        false;
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) !=
            null
        ? true
        : false;
  }

  UserProfile getUserProfile() {
    var profile =
        _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profile.isEmpty) {
      return UserProfile();
    }
    var profileJson = jsonDecode(profile);
    if (profileJson is Map<String, dynamic>) {
      var userProfile = UserProfile.fromJson(profileJson);
      return userProfile;
    }
    return UserProfile();
  }

  String getUserToken() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }
  Future<bool> remove(String key) async {
    return await _pref.remove(key);
  }
}
