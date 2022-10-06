import 'package:get/get.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/services/sources/transaction_sources.dart';

class TransactionController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _list = <TransactionModel>[].obs;
  List<TransactionModel> get list => _list.value;

  getList(idUser, type) async {
    _isLoading.value = true;
    update();

    _list.value = await TransactionSource.incomeOutcome(idUser, type);
    update();

    Future.delayed(
      Duration(seconds: 3),
      () {
        _isLoading.value = false;
        update();
      },
    );
  }

  getSearch(idUser, type, date) async {
    _isLoading.value = true;
    update();

    _list.value = await TransactionSource.inOutSearch(idUser, type, date);
    update();

    Future.delayed(
      Duration(seconds: 3),
      () {
        _isLoading.value = false;
        update();
      },
    );
  }
}
