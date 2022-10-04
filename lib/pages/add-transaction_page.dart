import 'dart:convert';

import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/services/app_format.dart';
import 'package:moneytoring/services/controllers/transaction/add-transaction_controller.dart';
import 'package:moneytoring/services/controllers/user_controller.dart';
import 'package:moneytoring/services/sources/transaction_sources.dart';
import 'package:moneytoring/shared/styles.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({Key? key}) : super(key: key);
  final _addTransactionController = Get.put(AddTransactionController());
  final _userController = Get.put(UserController());

  final _priceController = TextEditingController();
  final _nameController = TextEditingController();

  addTransaction() async {
    bool success = await TransactionSource.addTransaction(
      _userController.getData.idUser!,
      _addTransactionController.date,
      _addTransactionController.type,
      jsonEncode(_addTransactionController.items),
      _addTransactionController.total.toString(),
    );
    if (success) {
      Future.delayed(
        Duration(seconds: 3),
        () => Get.back(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Transaksi Baru'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Tanggal',
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            Row(
              children: [
                Obx(() => Text(
                      _addTransactionController.date,
                      style: blackTextStyle,
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
                    if (result != null) {
                      _addTransactionController.setDate(
                        DateFormat('yyyy-MM-dd').format(result),
                      );
                    }
                  },
                  icon: Icon(Icons.calendar_month_rounded),
                  label: Text(
                    'Tanggal',
                    style: whiteTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            DView.spaceHeight(),
            Text(
              'Tipe',
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            DView.spaceHeight(8),
            Obx(() => DropdownButtonFormField(
                  value: _addTransactionController.type,
                  items: ['Pemasukan', 'Pengeluaran'].map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value) {
                    _addTransactionController.setType(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                )),
            DView.spaceHeight(),
            DInput(
              controller: _nameController,
              title: 'Subjek/Objek Pengeluaran',
              hint: 'Pembelian',
            ),
            DView.spaceHeight(),
            DInput(
              controller: _priceController,
              title: 'Jumlah',
              hint: 'Jumlah Pengeluaran',
              inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () {
                _addTransactionController.addItem({
                  'name': _nameController.text,
                  'price': _priceController.text,
                });
                _nameController.clear();
                _priceController.clear();
              },
              child: Text(
                'Tambah ke item',
                style: whiteTextStyle,
              ),
            ),
            DView.spaceHeight(),
            Text(
              'Items',
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            DView.spaceHeight(8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: GetBuilder<AddTransactionController>(
                builder: (_) {
                  return Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: List.generate(
                      _.items.length,
                      (index) {
                        return Chip(
                          label: Text(
                            _.items[index]['name'],
                            style: blackTextStyle,
                          ),
                          deleteIcon: Icon(Icons.clear),
                          onDeleted: () => _.deleteItem(index),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Text(
                  'Total',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
                DView.spaceWidth(6),
                Obx(
                  () => Text(
                    AppFormat.currencyFormat(
                        _addTransactionController.total.toString()),
                    style: blueTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
            DView.spaceHeight(16),
            Material(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () {
                  addTransaction();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
