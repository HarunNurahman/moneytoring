import 'package:d_info/d_info.dart';
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

  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    String url = '${ApiServices.userUrl}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;
    if (responseBody['success']) {
      DInfo.dialogSuccess('Registrasi Berhasil');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'email') {
        DInfo.dialogSuccess('Email Sudah Terdaftar');
        DInfo.closeDialog();
      } else {
        DInfo.dialogSuccess('Registrasi Gagal!');
      }
    }

    return responseBody['success'];
  }
}
