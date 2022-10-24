import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/models/user_models.dart';
import 'package:moneytoring_devtest/pages/home_page.dart';
import 'package:moneytoring_devtest/pages/login_page.dart';
import 'package:moneytoring_devtest/services/api_services.dart';
import 'package:moneytoring_devtest/services/app_request.dart';
import 'package:moneytoring_devtest/services/session_services.dart';

class UserSource {
  // LOGIN Source
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

  // REGISTER Source
  // Calling register API Services
  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    // Access from AppRequest
    String url = '${ApiService.user}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      // Getting date/time when submit register
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    // Check register data availability
    // 1. Success state
    // 2. Email already register
    // 3. Register failed

    // If register success
    if (responseBody['success']) {
      DInfo.notifSuccess('Registrasi Berhasil', 'Silahkan Login Kembali!');
      Get.to(() => const LoginPage());
    } else {
      // If email already registered
      if (responseBody['message'] == 'email') {
        DInfo.notifError(
          'Registrasi Gagal',
          'Email Sudah Terdaftar, Silahkan Login',
        );
        Get.to(() => const LoginPage());
      } else {
        // If error from backend
        DInfo.notifError('Registrasi Gagal', 'Mohon Coba Beberapa Saat Lagi');
      }
    }

    return responseBody['success'];
  }
}
