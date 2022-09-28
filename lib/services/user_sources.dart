import 'package:moneytoring/models/user_model.dart';
import 'package:moneytoring/services/api_services.dart';
import 'package:moneytoring/services/app_request.dart';
import 'package:moneytoring/services/session_services.dart';

class UserSource {
  static Future<bool> login(String email, String password) async {
    String url = '${ApiServices.userUrl}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) return false;
    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUser(UserModel.fromJson(mapUser));
    }

    return responseBody['success'];
  }
}
