import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/services/api_services.dart';
import 'package:moneytoring/services/requests/app_request.dart';

class TransactionSource {
  static Future<Map> analysis(String idUser) async {
    String url = '${ApiServices.transactionUrl}/analysis.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now())
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

  static Future<bool> addTransaction(
    String idUser,
    String date,
    String type,
    String detail,
    String total,
  ) async {
    String url = '${ApiServices.transactionUrl}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
      'detail': detail,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;
    if (responseBody['success']) {
      DInfo.notifSuccess('Transaksi Berhasil', '');
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.toastError(
            'Transaksi dengan tanggal tersebut sudah pernah dibuat');
      } else {
        DInfo.toastError('Transaksi Gagal!');
      }
    }

    return responseBody['success'];
  }

  static Future<List<TransactionModel>> incomeOutcome(
    String idUser,
    String type,
  ) async {
    String url = '${ApiServices.transactionUrl}/income-outcome.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => TransactionModel.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<TransactionModel>> inOutSearch(
    String idUser,
    String type,
    String date,
  ) async {
    String url = '${ApiServices.transactionUrl}/income-outcome-search.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
      'date': date,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => TransactionModel.fromJson(e)).toList();
    }

    return [];
  }

  static Future<TransactionModel?> whereDate(
    String idUser,
    String type,
  ) async {
    String url = '${ApiServices.transactionUrl}/where-date.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      var list = responseBody['data'];
      return TransactionModel.fromJson(list);
    }

    return null;
  }

  static Future<bool> updateTransaction(
    String idTransaction,
    String idUser,
    String date,
    String type,
    String detail,
    String total,
  ) async {
    String url = '${ApiServices.transactionUrl}/update.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_transaction': idTransaction,
      'id_user': idUser,
      'date': date,
      'type': type,
      'detail': detail,
      'total': total,
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;
    if (responseBody['success']) {
      DInfo.notifSuccess('Update Berhasil', '');
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.toastError('Duplicated Transaction');
      } else {
        DInfo.toastError('Update Gagal!');
      }
    }

    return responseBody['success'];
  }
}
