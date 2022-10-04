import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring/pages/add-transaction_page.dart';
import 'package:moneytoring/pages/login_page.dart';
import 'package:moneytoring/services/app_format.dart';
import 'package:moneytoring/services/controllers/home_controller.dart';
import 'package:moneytoring/services/controllers/user_controller.dart';
import 'package:moneytoring/services/session_services.dart';
import 'package:moneytoring/shared/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userController = Get.put(UserController());
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    _homeController.getAnalysis(_userController.getData.idUser!);

    super.initState();
  }

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
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 0),
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            Obx(
                              () {
                                return Text(
                                  _userController.getData.name ?? '',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                );
                              },
                            ),
                            Obx(
                              () {
                                return Text(
                                  _userController.getData.email ?? '',
                                  style: blackTextStyle,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  DView.spaceHeight(20),
                  Material(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        Session.deleteUser();
                        Get.off(() => LoginPage());
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Text(
                          'Logout',
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(AddTransaction());
              },
              leading: const Icon(Icons.add),
              horizontalTitleGap: 0,
              title: Text(
                'Tambah Transaksi Baru',
                style: blackTextStyle,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.south_west),
              horizontalTitleGap: 0,
              title: Text(
                'Pemasukan',
                style: blackTextStyle,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.north_east),
              horizontalTitleGap: 0,
              title: Text(
                'Pengeluaran',
                style: blackTextStyle,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.history),
              horizontalTitleGap: 0,
              title: Text(
                'Riwayat Transaksi',
                style: blackTextStyle,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 1)
          ],
        ),
      ),
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
              child: RefreshIndicator(
                onRefresh: () async {
                  _homeController.getAnalysis(_userController.getData.idUser!);
                },
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
                            child: Obx(() {
                              return Text(
                                AppFormat.currencyFormat(
                                  _homeController.todayTransaction.toString(),
                                ),
                                style: whiteTextStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: semiBold,
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 24),
                            child: Obx(
                              () => Text(
                                _homeController.todayPercentage,
                                style: whiteTextStyle,
                              ),
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
                      child: Obx(() => DChartBar(
                            data: [
                              {
                                'id': 'Bar',
                                'data': List.generate(
                                  7,
                                  (index) => {
                                    'domain': _homeController.week()[index],
                                    'measure': _homeController
                                        .weeklyTransaction[index],
                                  },
                                )
                              },
                            ],
                            domainLabelPaddingToAxisLine: 16,
                            axisLineTick: 2,
                            axisLineColor: kPrimaryColor,
                            measureLabelPaddingToAxisLine: 16,
                            barColor: (barData, index, id) => kPrimaryColor,
                            showBarValue: true,
                          )),
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
                              Obx(
                                () => DChartPie(
                                  data: [
                                    {
                                      'domain': 'income',
                                      'measure': _homeController.monthlyIncome,
                                    },
                                    {
                                      'domain': 'outcome',
                                      'measure': _homeController.monthlyOutcome,
                                    },
                                    if (_homeController.monthlyIncome == 0 &&
                                        _homeController.monthlyOutcome == 0)
                                      {'domain': 'nol', 'measure': 1}
                                  ],
                                  fillColor: (pieData, index) {
                                    switch (pieData['domain']) {
                                      case 'income':
                                        return kPrimaryColor;
                                      case 'outcome':
                                        return kChartColor;
                                      default:
                                        return kBackgroundColor
                                            .withOpacity(0.5);
                                    }
                                  },
                                  donutWidth: 20,
                                  showLabelLine: false,
                                  labelColor: Colors.white,
                                ),
                              ),
                              Center(
                                child: Obx(
                                  () => Text(
                                      '${_homeController.incomePercentage}'),
                                ),
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
                            Obx(() => Text(
                                  _homeController.monthlyPercentage,
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                )),
                            DView.spaceHeight(10),
                            Text(
                              'Atau Setara',
                              style: blackTextStyle.copyWith(fontSize: 12),
                            ),
                            Text(
                              AppFormat.currencyFormat(
                                _homeController.differentMonth.toString(),
                              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
