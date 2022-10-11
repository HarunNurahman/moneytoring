import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = Get.put(UserController());

  // Greeting timer
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    }
    if (hour < 17) {
      return 'Selamat Siang';
    }
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context) {
    // Header (Image profile, name, drawer button)
    Widget header() {
      return Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(AppAssets.imgProfile),
          ),
          DView.spaceWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${greeting()}, ',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                // Get Name data from UserController
                Obx(
                  () => Text(
                    userController.data.name ?? '',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kLightBlueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.menu_rounded,
                  color: kPrimaryColor,
                ),
              ),
            );
          }),
        ],
      );
    }

    // Daily outcome card
    Widget todayOutcome() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengeluaran Hari Ini',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          DView.spaceHeight(),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                            child: Text(
                              'IDR 500.000',
                              style: cyanTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Text(
                              '+20% dibanding kemarin',
                              style: cyanTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Image.asset(
                          AppAssets.appLogo,
                          width: 56,
                        ),
                      )
                    ],
                  ),
                  DView.spaceHeight(24),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                    padding: const EdgeInsets.all(4),
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
                          style: blueTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    // Weekly outcome bar chart
    Widget weeklyOutcome() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengeluaran Minggu Ini',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          DView.spaceHeight(),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DChartBar(
              data: [
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
        ],
      );
    }

    // Monthly outcome pie chart
    Widget monthlyOutcome() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengeluaran Bulan Ini',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              // Pie chart
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Stack(
                  children: [
                    DChartPie(
                      data: [
                        {'domain': 'Flutter', 'measure': 28},
                        {'domain': 'React Native', 'measure': 27},
                      ],
                      fillColor: (pieData, index) => Colors.purple,
                      donutWidth: 30,
                      labelColor: Colors.white,
                    ),
                    Center(
                      child: Text(
                        '60%',
                        style: blueTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: light,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Detail outcome information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // income color code
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          color: kPrimaryColor,
                        ),
                        DView.spaceWidth(8),
                        Text(
                          'Pemasukan',
                          style: blackTextStyle,
                        )
                      ],
                    ),
                    DView.spaceWidth(8),
                    // Outcome color code
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          color: kCyanColor,
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
                      'Pemasukkan lebih besar 20% dari Pengeluaran',
                      style: blackTextStyle.copyWith(fontWeight: light),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    DView.spaceHeight(10),
                    RichText(
                      text: TextSpan(
                        text: 'Atau setara:',
                        style: blackTextStyle,
                        children: [
                          TextSpan(
                            text: '\nIDR 20.000',
                            style: blueTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          )
                        ],
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

    return Scaffold(
      endDrawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 24,
        ),
        child: Column(
          children: [
            header(),
            // Body (Outcome daily, weekly, monthly)
            Expanded(
              child: ListView(
                children: [
                  todayOutcome(),
                  DView.spaceHeight(24),
                  // Divider
                  Center(
                    child: Container(
                      height: 5,
                      width: 20,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  DView.spaceHeight(24),
                  weeklyOutcome(),
                  DView.spaceHeight(32),
                  monthlyOutcome(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
