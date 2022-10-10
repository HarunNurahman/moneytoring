import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/pages/edit-transaction_page.dart';
import 'package:moneytoring/services/app_format.dart';
import 'package:moneytoring/services/controllers/transaction/transaction_controller.dart';
import 'package:moneytoring/services/controllers/user_controller.dart';
import 'package:moneytoring/services/sources/transaction_sources.dart';
import 'package:moneytoring/shared/styles.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final transactionController = Get.put(TransactionController());
  final userController = Get.put(UserController());

  final TextEditingController _searchController = TextEditingController();

  onRefresh() {
    transactionController.getList(userController.getData.idUser, widget.type);
  }

  options(String value, TransactionModel transaction) async {
    if (value == 'update') {
      Get.to(
        EditTransasction(
          date: transaction.date!,
          idTransaction: transaction.idTransaction!,
        ),
      )?.then((value) {
        if (value ?? false) {
          onRefresh();
        }
      });
    } else if (value == 'delete') {
      bool? isDelete = await DInfo.dialogConfirmation(
        context,
        'Hapus Transaksi!',
        'Apa anda yakin ingin menghapus transaksi?',
        textNo: 'Batal',
        textYes: 'Hapus Transaksi',
      );

      if (isDelete!) {
        bool success = await TransactionSource.deleteTransaction(
            transaction.idTransaction!);
        if (success) onRefresh();
      }
    }
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
                        transactionController.getSearch(
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
      body: GetBuilder<TransactionController>(
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
                TransactionModel transaction = _.list[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == _.list.length ? 16 : 8,
                  ),
                  child: Row(
                    children: [
                      DView.spaceWidth(),
                      Text(
                        AppFormat.dateFormat(transaction.date!),
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppFormat.currencyFormat(transaction.total!),
                          style: blueTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) => options(value, transaction),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'update',
                            child: Text(
                              'Update',
                              style: blackTextStyle.copyWith(fontSize: 12),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: blackTextStyle.copyWith(fontSize: 12),
                            ),
                          )
                        ],
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
