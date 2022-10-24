import 'dart:convert';

import 'package:get/get.dart';
import 'package:moneytoring_devtest/models/history_models.dart';
import 'package:moneytoring_devtest/services/source/history_source.dart';

class DetailHistoryController extends GetxController {
  final _data = HistoryModel().obs;
  HistoryModel get data => _data.value;

  getData(idUser, date, type) async {
    HistoryModel? historyModel = await HistorySource.detailTransaction(
      idUser,
      date,
      type,
    );
    _data.value = historyModel ?? HistoryModel();
    update();
  }
}
