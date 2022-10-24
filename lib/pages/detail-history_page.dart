import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring_devtest/controller/detail-history_controller.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/styles.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({
    super.key,
    required this.idUser,
    required this.date,
    required this.type,
  });
  final String idUser;
  final String date;
  final String type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final detailHistoryController = Get.put(DetailHistoryController());

  @override
  void initState() {
    detailHistoryController.getData(
      widget.idUser,
      widget.date,
      widget.type,
    );
    super.initState();
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Obx(
        () {
          if (detailHistoryController.data.date == null) return DView.nothing();
          return Row(
            children: [
              Expanded(
                child: Text(
                  AppFormat.dateFormat(detailHistoryController.data.date!),
                  style: whiteTextStyle,
                ),
              ),
              detailHistoryController.data.type == 'Pemasukkan'
                  ? const Icon(
                      Icons.south_west_rounded,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.north_east_rounded,
                      color: Colors.red,
                    ),
              DView.spaceWidth(),
            ],
          );
        },
      ),
      titleSpacing: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<DetailHistoryController>(
        builder: (_) {
          if (_.data.date == null) {
            String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
            if (widget.date == today && widget.type == 'Pengeluaran') {
              return DView.empty('Belum Ada Pengeluaran');
            }
            return DView.nothing();
          }
          List detail = jsonDecode(_.data.detail!);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Total',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    )),
              ),
              DView.spaceHeight(8),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Text(
                  AppFormat.currencyFormat(_.data.total!),
                  style: blueTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              DView.spaceHeight(20),
              Center(
                child: Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kBlueColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              DView.spaceHeight(20),
              Expanded(
                child: ListView.separated(
                  itemCount: detail.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: kBlackColor,
                  ),
                  itemBuilder: (context, index) {
                    Map item = detail[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text('${index + 1}.', style: blackTextStyle),
                          DView.spaceWidth(8),
                          Expanded(
                            child: Text(item['item'], style: blackTextStyle),
                          ),
                          Text(
                            AppFormat.currencyFormat(item['value']),
                            style: blackTextStyle,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
