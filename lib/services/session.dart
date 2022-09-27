import 'dart:convert';

import 'package:moneytoring/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> saveUser(UserModel userModel) async {
    final pref = await SharedPreferences.getInstance();

    Map<String, dynamic> mapUser = userModel.toJson();
    String user = jsonEncode(mapUser);

    bool success = await pref.setString('tb_user', user);
    return success;
  }

  static Future<UserModel> getUser(UserModel userModel) async {
    UserModel userModel = UserModel();
    final pref = await SharedPreferences.getInstance();

    String? user = pref.getString('tb_user');
    if (user != null) {
      Map<String, dynamic> mapUser = jsonDecode(user);
      user = UserModel.fromJson(mapUser) as String?;
    }
    return userModel;
  }

  static Future<bool> deleteUser() async {
    final pref = await SharedPreferences.getInstance();

    bool isSuccess = await pref.remove('tb_user');
    return isSuccess;
  }
}
