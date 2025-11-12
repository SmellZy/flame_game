import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> createUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const _userKey = 'user_data';

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<void> createUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final existingUser = prefs.getString(_userKey);
    if (existingUser == null) {
      await prefs.setString(_userKey, jsonEncode(user.toJson())); 
    }
  }
}
