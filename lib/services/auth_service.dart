import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier{
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String userName) async {
      _prefs.setString('userName', userName);
  }

  Future<bool> isLoggedIn() async {
    String? username = _prefs.getString('userName');// await here
    if (username == null) return false;
    return true;
  }

  void logoutUser() {
    _prefs.clear();
  }

  String? getUserName() {
    return _prefs.getString('userName') ?? 'DefaultValue';
  }

  void updateUserName(String newName) {
    _prefs.setString('userName', newName);
    notifyListeners();
  }
}