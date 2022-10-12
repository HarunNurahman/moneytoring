import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:moneytoring_devtest/styles.dart';

class AddHistoryPage extends StatelessWidget {
  AddHistoryPage({Key? key}) : super(key: key);

  TextEditingController objectController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController valueController = TextEditingController();

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
              Text(
                '2022-10-12',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  color: kBlackColor.withOpacity(0.8),
                ),
              ),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: kWhiteColor,
                ),
                label: Text(
                  'Pilih',
                  style: whiteTextStyle,
                ),
              )
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: DView.appBarLeft('Tambah Transaksi Baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(),
          DView.spaceHeight(),
          // Transaction type
          Text('Tipe', style: blackTextStyle.copyWith(fontWeight: semiBold)),
          DView.spaceHeight(8),
          DropdownButtonFormField(
            value: 'Pemasukan',
            items: ['Pemasukan', 'Pengeluaran'].map(
              (e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              },
            ).toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
          ),
          DView.spaceHeight(24),
          // Object Income / Outcome
          Text(
            'Objek Pemasukan atau Pengeluaran',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          DView.spaceHeight(8),
          DInput(
            controller: sourceController,
            hint: 'Gajian',
          ),
          DView.spaceHeight(24),
          // Value
          Text(
            'Nilai Jumlah',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          DView.spaceHeight(8),
          DInput(
            controller: sourceController,
            inputType: TextInputType.number,
            hint: '3000000',
          ),
          DView.spaceHeight(24),
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
        ],
      ),
    );
  }
}
