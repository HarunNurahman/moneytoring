import 'dart:convert';

import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring_devtest/controller/update-history_controller.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/services/source/history_source.dart';
import 'package:moneytoring_devtest/styles.dart';

class UpdateHistoryPage extends StatefulWidget {
  const UpdateHistoryPage({
    Key? key,
    required this.date,
    required this.idTransaction,
  }) : super(key: key);
  final String date;
  final String idTransaction;

  @override
  State<UpdateHistoryPage> createState() => _UpdateHistoryPageState();
}

class _UpdateHistoryPageState extends State<UpdateHistoryPage> {
  TextEditingController itemController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  final updateHistoryController = Get.put(UpdateHistoryController());
  final userController = Get.put(UserController());

  updateHistory() async {
    bool success = await HistorySource.updateTransaction(
      widget.idTransaction,
      userController.data.idUser!,
      updateHistoryController.date,
      updateHistoryController.type,
      jsonEncode(updateHistoryController.item),
      updateHistoryController.total.toString(),
    );
    if (success) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.back(result: true),
      );
    }
  }

  @override
  void initState() {
    updateHistoryController.init(userController.data.idUser, widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Header (choose date)
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tanggal', style: blackTextStyle.copyWith(fontWeight: semiBold)),
          // Select date button
          Row(
            children: [
              Obx(() => Text(
                    updateHistoryController.date,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      color: kBlackColor.withOpacity(0.8),
                    ),
                  )),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022, 01, 01),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  // Check if there is a date that we choose and add to Controller
                  if (result != null) {
                    updateHistoryController.setDate(
                      DateFormat('yyyy-MM-dd').format(result),
                    );
                  }
                },
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: kWhiteColor,
                ),
                label: Text(
                  'Pilih',
                  style: whiteTextStyle,
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Body (tipe transaksi, objek pemasukan/pengeluaran, nilai transaksi, daftar transaksi, total transaksi)
    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transaction type
          Text('Tipe', style: blackTextStyle.copyWith(fontWeight: semiBold)),
          DView.spaceHeight(8),
          Obx(
            () => DropdownButtonFormField(
              value: updateHistoryController.type,
              items: ['Pemasukan', 'Pengeluaran'].map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(),
              onChanged: (value) {
                updateHistoryController.setType(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
            ),
          ),
          DView.spaceHeight(24),
          // Object Income / Outcome
          Text(
            'Objek Pemasukan / Pengeluaran',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          DView.spaceHeight(8),
          DInput(
            controller: itemController,
            hint: 'Contoh: Gajian, Kopi',
          ),
          DView.spaceHeight(24),
          // Value
          Text(
            'Nilai Jumlah',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          DView.spaceHeight(8),
          DInput(
            controller: valueController,
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          // Add to transaction item
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                updateHistoryController.addItem({
                  'item': itemController.text,
                  'value': valueController.text,
                });
                itemController.clear();
                valueController.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                'Tambah Transaksi',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
          DView.spaceHeight(16),
          Center(
            child: Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(24),
          // Transaction items
          Text(
            'Daftar Transaksi',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          DView.spaceHeight(8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: GetBuilder<UpdateHistoryController>(
              builder: (_) {
                return Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(
                    _.item.length,
                    (index) {
                      return Chip(
                        backgroundColor: kPrimaryColor,
                        label: Text(
                          _.item[index]['item'],
                          style: whiteTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        deleteIcon: const Icon(Icons.clear_rounded),
                        deleteIconColor: kWhiteColor,
                        onDeleted: () => _.deleteItem(index),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          DView.spaceHeight(24),
          // Total transaction
          Row(
            children: [
              Obx(() => RichText(
                    text: TextSpan(
                      text: 'Total Transaksi: \n',
                      style: blackTextStyle,
                      children: [
                        TextSpan(
                          text: AppFormat.currencyFormat(
                            updateHistoryController.total.toString(),
                          ),
                          style: blueTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ],
      );
    }

    // Add transaction button
    Widget submitTransaction() {
      return Container(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () => updateHistory(),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Selesaikan Transaksi',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: DView.appBarLeft('Ubah Transaksi'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(),
          DView.spaceHeight(),
          body(),
          DView.spaceHeight(24),
          submitTransaction(),
        ],
      ),
    );
  }
}
