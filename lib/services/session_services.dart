import 'dart:convert';

import 'package:get/get.dart';
import 'package:moneytoring/services/user_controller.dart';
import 'package:moneytoring/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> saveUser(UserModel userModel) async {
    final pref = await SharedPreferences.getInstance();

    Map<String, dynamic> mapUser = userModel.toJson();
    String user = jsonEncode(mapUser);

    bool success = await pref.setString('tb_user', user);

    if (success) {
      final userController = Get.put(UserController());
      userController.setData(userModel);
    }
    return success;
  }

  static Future<UserModel> getUser() async {
    UserModel userModel = UserModel();
    final pref = await SharedPreferences.getInstance();

    String? user = pref.getString('tb_user');
    if (user != null) {
      Map<String, dynamic> mapUser = jsonDecode(user);
      user = UserModel.fromJson(mapUser) as String?;
    }
    final userController = Get.put(UserController());
    userController.setData(userModel);

    return userModel;
  }

  static Future<bool> deleteUser() async {
    final pref = await SharedPreferences.getInstance();

    bool isSuccess = await pref.remove('tb_user');
    final userController = Get.put(UserController());
    userController.setData(UserModel());

    return isSuccess;
  }
}
