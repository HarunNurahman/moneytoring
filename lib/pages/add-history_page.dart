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

    // Body (tipe transaksi, objek pemasukan/pengeluaran, nilai transaksi, daftar transaksi, total transaksi)
    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: Chip(
              label: Text(
                'Bensin',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              deleteIcon: const Icon(Icons.clear_rounded),
              onDeleted: () {},
            ),
          ),
          DView.spaceHeight(24),
          // Total transaction
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Total Transaksi: \n',
                  style: blackTextStyle,
                  children: [
                    TextSpan(
                      text: AppFormat.currencyFormat('300000'),
                      style: blueTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
              ),
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
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
      );
    }

    return Scaffold(
      appBar: DView.appBarLeft('Tambah Transaksi Baru'),
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
