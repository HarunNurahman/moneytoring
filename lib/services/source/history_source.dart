import 'package:intl/intl.dart';
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
}
