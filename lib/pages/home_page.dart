import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring/services/user_controller.dart';
import 'package:moneytoring/shared/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userController = Get.put(UserController());

  // Greeting timer
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi,';
    }
    if (hour < 17) {
      return 'Selamat Siang,';
    }
    return 'Selamat Malam,';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/img_profile.png',
                  width: 50,
                ),
                DView.spaceWidth(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting(),
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      Obx(
                        () {
                          return Text(
                            _userController.getData.name ?? '',
                            style: blackTextStyle.copyWith(fontSize: 16),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    return Material(
                      color: kChartColor,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Icon(Icons.menu),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  DView.spaceHeight(30),
                  Text(
                    'Pengeluaran Hari Ini',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  DView.spaceHeight(10),
                  Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 4,
                    color: kPrimaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 0, 6),
                          child: Text(
                            'Rp 500.000,00',
                            style: whiteTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 0, 24),
                          child: Text(
                            '+20% dibanding kemarin',
                            style: whiteTextStyle,
                          ),
                        ),
                        DView.spaceHeight(30),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 24,
                            bottom: 24,
                          ),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Selengkapnya',
                                style: blueTextStyle,
                              ),
                              Icon(
                                Icons.navigate_next_rounded,
                                color: kPrimaryColor,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  DView.spaceHeight(30),
                  Text(
                    'Pengeluaran Minggu Ini',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  DView.spaceHeight(30),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartBar(
                      data: const [
                        {
                          'id': 'Bar',
                          'data': [
                            {'domain': '2020', 'measure': 3},
                            {'domain': '2021', 'measure': 4},
                            {'domain': '2022', 'measure': 6},
                            {'domain': '2023', 'measure': 0.3},
                          ],
                        },
                      ],
                      domainLabelPaddingToAxisLine: 16,
                      axisLineTick: 2,
                      axisLinePointTick: 2,
                      axisLinePointWidth: 10,
                      axisLineColor: Colors.green,
                      measureLabelPaddingToAxisLine: 16,
                      barColor: (barData, index, id) => Colors.green,
                      showBarValue: true,
                    ),
                  ),
                  DView.spaceHeight(30),
                  Text(
                    'Pengeluaran Bulan Ini',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  DView.spaceHeight(30),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: Stack(
                          children: [
                            DChartPie(
                              data: [
                                {'domain': 'Flutter', 'measure': 28},
                                {'domain': 'React Native', 'measure': 27},
                                {'domain': 'Ionic', 'measure': 20},
                                {'domain': 'Cordova', 'measure': 15},
                              ],
                              fillColor: (pieData, index) => Colors.purple,
                              donutWidth: 30,
                              labelColor: Colors.white,
                            ),
                            Center(
                              child: Text('60%'),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: kPrimaryColor,
                              ),
                              DView.spaceWidth(8),
                              Text(
                                'Pemasukan',
                                style: blackTextStyle,
                              )
                            ],
                          ),
                          DView.spaceHeight(10),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: kChartColor,
                              ),
                              DView.spaceWidth(8),
                              Text(
                                'Pengeluaran',
                                style: blackTextStyle,
                              )
                            ],
                          ),
                          DView.spaceHeight(20),
                          Text(
                            'Pemasukan \nlebih besar 20% \ndari pengeluaran \n\natau setara:',
                            style: blackTextStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            'Rp 200.000,00',
                            style: blueTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
