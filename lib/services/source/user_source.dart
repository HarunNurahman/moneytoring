import 'package:moneytoring_devtest/models/user_models.dart';
import 'package:moneytoring_devtest/services/api_services.dart';
import 'package:moneytoring_devtest/services/app_request.dart';
import 'package:moneytoring_devtest/services/session_services.dart';

class UserSource {
  // Calling login API Services
  static Future<bool> login(String email, String password) async {
    // Access from AppRequest
    String url = '${ApiService.user}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) return false;

    // Check data availability
    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      SessionServices.saveCurrentUser(UserModel.fromJson(mapUser));
    }

    return responseBody['success'];
  }
}
