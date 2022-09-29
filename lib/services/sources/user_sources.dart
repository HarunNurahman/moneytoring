import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import 'package:moneytoring/models/user_model.dart';
import 'package:moneytoring/pages/home_page.dart';
import 'package:moneytoring/pages/login_page.dart';
import 'package:moneytoring/services/api_services.dart';
import 'package:moneytoring/services/requests/app_request.dart';
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
      DInfo.notifSuccess('Login Berhasil', 'Selamat Datang');
      var mapUser = responseBody['data'];
      Session.saveUser(UserModel.fromJson(mapUser));
      Get.to(() => HomePage());
    } else {
      DInfo.notifError('Login Gagal', 'Email atau Password Salah');
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
      DInfo.notifSuccess('Registrasi Berhasil', 'Silahkan Login');
      Get.to(LoginPage());
    } else {
      if (responseBody['data'] == 'email') {
        DInfo.toastError('Email Sudah Terdaftar');
      } else {
        DInfo.toastError('Registrasi Gagal!');
      }
    }

    return responseBody['success'];
  }
}
