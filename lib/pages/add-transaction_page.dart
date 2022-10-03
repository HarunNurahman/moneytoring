import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:moneytoring/services/app_format.dart';
import 'package:moneytoring/shared/styles.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

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
                Text(
                  '2022-10-03',
                  style: blackTextStyle,
                ),
                DView.spaceWidth(),
                ElevatedButton.icon(
                  onPressed: () {},
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
            DropdownButtonFormField(
              value: 'Pemasukan',
              items: ['Pemasukan', 'Pengeluaran'].map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            DView.spaceHeight(),
            DInput(
              controller: TextEditingController(),
              title: 'Subjek/Objek Pengeluaran',
              hint: 'Pembelian',
            ),
            DView.spaceHeight(),
            DInput(
              controller: TextEditingController(),
              title: 'Jumlah',
              hint: 'Jumlah Pengeluaran',
              inputType: TextInputType.number,
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
              child: Wrap(
                children: [
                  Chip(
                    label: Text(
                      'Sumber',
                      style: blackTextStyle,
                    ),
                    deleteIcon: const Icon(Icons.clear),
                    onDeleted: () {},
                  )
                ],
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
                Text(
                  AppFormat.currencyFormat(
                    '300000',
                  ),
                  style: blueTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            DView.spaceHeight(16),
            Material(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
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
