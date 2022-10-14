import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring_devtest/models/history_models.dart';
import 'package:moneytoring_devtest/pages/home_page.dart';
import 'package:moneytoring_devtest/pages/login_page.dart';
import 'package:moneytoring_devtest/services/api_services.dart';
import 'package:moneytoring_devtest/services/app_request.dart';

class HistorySource {
  // ANALYSIS Source
  // Calling analysis from APIService
  static Future<Map> analysis(String idUser) async {
    // Access from AppRequest
    String url = '${ApiService.history}/analysis.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      // Convert to 'yyyy-MM-dd' from today
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });

    if (responseBody == null) {
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {
          'income': 0.0,
          'outcome': 0.0,
        }
      };
    }

    return responseBody;
  }

  // ADD TRANSACTION Source
  static Future<bool> addTransaction(
    String idUser,
    String date,
    String type,
    String detail,
    String total,
  ) async {
    // Access from AppRequest
    String url = '${ApiService.history}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
      'detail': detail,
      'total': total,
      // Getting date/time when submit register
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    // Check add transaction state
    // 1. Transaction success state
    // 2. Transaction has been done
    // 3. Transaction failed

    // If transaction success
    if (responseBody['success']) {
      DInfo.notifSuccess('Berhasil', 'Transaksi Berhasil!');
      Get.to(() => const HomePage());
    } else {
      // If transaction already been done on same date
      if (responseBody['message'] == 'date') {
        DInfo.notifError(
          'Transaksi Gagal',
          'Transaksi Dengan Tanggal Tersebut Sudah Dibuat',
        );
        Get.to(() => const LoginPage());
      } else {
        // If error from backend
        DInfo.notifError('Transaksi Gagal', 'Mohon Coba Beberapa Saat Lagi');
      }
    }

    return responseBody['success'];
  }

  // Get Transaction based on type (Income or Outcome)
  static Future<List<HistoryModel>> incomeOutcome(
      String idUser, String type) async {
    // Access from AppRequest
    String url = '${ApiService.history}/income-outcome.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
    });

    // If response body is null
    if (responseBody == null) return [];

    // Response body is success and insert to $data list
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => HistoryModel.fromJson(e)).toList();
    }

    return [];
  }

  // Search transaction
  static Future<List<HistoryModel>> incomeOutcomeSearch(
    String idUser,
    String type,
    String date,
  ) async {
    // Access from AppRequest
    String url = '${ApiService.history}/income-outcome-search.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
      'date': date,
    });

    // If response body is null
    if (responseBody == null) return [];

    // Response body is success and insert to $data list
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => HistoryModel.fromJson(e)).toList();
    }

    return [];
  }
}
