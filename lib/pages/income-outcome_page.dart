import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring_devtest/controller/income-outcome_controller.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/models/history_models.dart';
import 'package:moneytoring_devtest/pages/detail-history_page.dart';
import 'package:moneytoring_devtest/pages/update-history_page.dart';
import 'package:moneytoring_devtest/services/source/history_source.dart';
import 'package:moneytoring_devtest/styles.dart';

class IncomeOutcomePage extends StatefulWidget {
  const IncomeOutcomePage({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<IncomeOutcomePage> createState() => _IncomeOutcomePageState();
}

class _IncomeOutcomePageState extends State<IncomeOutcomePage> {
  final incomeOutcomeController = Get.put(IncomeOutcomeController());
  final userController = Get.put(UserController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  menuOptions(String value, HistoryModel historyModel) async {
    if (value == 'update') {
      Get.to(
        () => UpdateHistoryPage(
          date: historyModel.date!,
          idTransaction: historyModel.idTransaction!,
        ),
      )?.then((value) {
        if (value ?? false) {
          onRefresh();
        }
      });
    } else if (value == 'delete') {
      bool? isDelete = await DInfo.dialogConfirmation(
        context,
        'Hapus Transaksi?',
        'Anda Yakin Ingin Menghapus Transaksi Ini?',
        textNo: 'Batal',
        textYes: 'Hapus',
      );

      if (isDelete!) {
        bool success = await HistorySource.deleteTransaction(
          historyModel.idTransaction!,
        );
        if (success) onRefresh();
      }
    }
  }

  Future<void> onRefresh() {
    return incomeOutcomeController.getList(
      userController.data.idUser,
      widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    // App bar widget
    PreferredSizeWidget appBar() {
      return AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              widget.type,
              style: whiteTextStyle.copyWith(fontSize: 14),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 24),
                height: 40,
                child: TextField(
                  controller: searchController,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      searchController.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: kCyanColor.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {
                        incomeOutcomeController.searchList(
                          userController.data.idUser,
                          widget.type,
                          searchController.text,
                        );
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: kWhiteColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    hintText: AppFormat.dateFormat2(DateTime.now().toString()),
                    hintStyle: whiteTextStyle,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: whiteTextStyle,
                  showCursor: false,
                  readOnly: true,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Listview transaction (income and outcome)
    Widget listTransaction() {
      return GetBuilder<IncomeOutcomeController>(
        builder: (_) {
          // loading state
          if (_.loading) return DView.loadingCircle();
          // if data is empty
          if (_.list.isEmpty) return DView.empty('Data Kosong');
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                HistoryModel historyModel = _.list[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == _.list.length ? 16 : 8,
                  ),
                  child: InkWell(
                    onTap: () => Get.to(() => DetailHistoryPage(
                          idUser: userController.data.idUser!,
                          date: historyModel.date!,
                          type: historyModel.type!,
                        )),
                    child: Row(
                      children: [
                        DView.spaceWidth(),
                        Text(
                          AppFormat.dateFormat(historyModel.date!),
                          style: blackTextStyle.copyWith(
                            fontWeight: light,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppFormat.currencyFormat(historyModel.total!),
                            style: blueTextStyle.copyWith(fontWeight: semiBold),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'update',
                              child: Text(
                                'Ubah',
                                style: blackTextStyle.copyWith(fontSize: 12),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                'Hapus',
                                style: blackTextStyle.copyWith(fontSize: 12),
                              ),
                            )
                          ],
                          onSelected: (value) => menuOptions(
                            value,
                            historyModel,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: listTransaction(),
    );
  }
}
