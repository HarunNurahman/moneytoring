import 'dart:convert';

import 'package:get/get.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionServices {
  // Save current user / session function
  // Model -> Object Map -> String -> Save user
  static Future<bool> saveCurrentUser(UserModel userModel) async {
    // Get instances
    final prefs = await SharedPreferences.getInstance();

    // Execute sessions
    // Encode from Model to String
    Map<String, dynamic> mapUser = userModel.toJson();
    String stringUser = jsonEncode(mapUser);

    // Checking to proceed saving useer session to controller
    bool success = await prefs.setString('user', stringUser);
    if (success) {
      final userController = Get.put(UserController());
      // If saving process is failed, the data wont be saved to controller
      userController.setData(userModel);
    }

    return success;
  }

  // Get current user data
  // String -> Object Map -> Model
  static Future<UserModel> getCurrentUser() async {
    // Default value
    UserModel userModel = UserModel();

    // Get instances
    final prefs = await SharedPreferences.getInstance();
    // Call user data from SharedPreferences
    String? stringUser = prefs.getString('user');

    // Checking if stringUser is null or session is unavailable
    if (stringUser != null) {
      // Decode from String/Map to Model
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      userModel = UserModel.fromJson(mapUser);
    }

    final userController = Get.put(UserController());
    // If saving process is failed, the data wont be saved to controller
    userController.setData(userModel);

    return userModel;
  }

  // Delete user session
  static Future<bool> deleteCurrentUser() async {
    // Get instances
    final prefs = await SharedPreferences.getInstance();

    // Checking if current user session is deleted
    bool success = await prefs.remove('user');
    final userController = Get.put(UserController());
    // If saving process is failed, the data wont be saved to controller
    userController.setData(UserModel());
    return success;
  }
}
