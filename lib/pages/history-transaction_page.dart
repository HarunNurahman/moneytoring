import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/services/app_format.dart';
import 'package:moneytoring/services/controllers/transaction/history-transaction_controller.dart';
import 'package:moneytoring/services/controllers/user_controller.dart';
import 'package:moneytoring/shared/styles.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  final historyTransaction = Get.put(HistoryTransactionController());
  final userController = Get.put(UserController());

  final TextEditingController _searchController = TextEditingController();

  onRefresh() {
    historyTransaction.getList(userController.getData.idUser, widget.type);
  }

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text(widget.type),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: TextField(
                  showCursor: false,
                  controller: _searchController,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      _searchController.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        historyTransaction.getSearch(
                          userController.getData.idUser,
                          widget.type,
                          _searchController.text,
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: kWhiteColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: kChartColor.withOpacity(0.4),
                    hintText: 'Tanggal',
                    hintStyle: whiteTextStyle.copyWith(fontSize: 12),
                  ),
                  style: whiteTextStyle,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
            )
          ],
        ),
      ),
      body: GetBuilder<HistoryTransactionController>(
        builder: (_) {
          if (_.isLoading) return DView.loadingCircle();
          if (_.list.isEmpty) return DView.empty('Data Kosong');
          return RefreshIndicator(
            onRefresh: () async {
              onRefresh();
            },
            child: ListView.builder(
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                TransactionModel _transaction = _.list[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == 8 ? 16 : 8,
                  ),
                  child: Row(
                    children: [
                      DView.spaceWidth(),
                      Text(
                        AppFormat.dateFormat(_transaction.date!),
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppFormat.currencyFormat(_transaction.total!),
                          style: blueTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [],
                        onSelected: (value) {},
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
