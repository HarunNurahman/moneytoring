import 'package:get/get.dart';
import 'package:moneytoring_devtest/models/history_models.dart';
import 'package:moneytoring_devtest/services/source/history_source.dart';

class IncomeOutcomeController extends GetxController {
  // Loading function
  final _loading = false.obs;
  bool get loading => _loading.value;

  // Get transaction data from model
  final _list = <HistoryModel>[].obs;
  List<HistoryModel> get list => _list.value;

  // Post transaction data
  getList(idUser, type) async {
    // Loading
    _loading.value = true;
    update();

    // Show Data
    _list.value = await HistorySource.incomeOutcome(idUser, type);
    update();

    // Loaded
    Future.delayed(const Duration(milliseconds: 1000), () {
      _loading.value = false;
      update();
    });
  }

  // Search list
  searchList(idUser, type, date) async {
    // Loading
    _loading.value = true;
    update();

    // Show Data
    _list.value = await HistorySource.incomeOutcomeSearch(idUser, type, date);
    update();

    // Loaded
    Future.delayed(const Duration(milliseconds: 1000), () {
      _loading.value = false;
      update();
    });
  }
}
