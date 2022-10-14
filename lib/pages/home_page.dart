import 'package:d_chart/d_chart.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/controller/home_controller.dart';
import 'package:moneytoring_devtest/controller/user_controller.dart';
import 'package:moneytoring_devtest/pages/add-history_page.dart';
import 'package:moneytoring_devtest/pages/income-outcome_page.dart';
import 'package:moneytoring_devtest/pages/login_page.dart';
import 'package:moneytoring_devtest/services/session_services.dart';
import 'package:moneytoring_devtest/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = Get.put(UserController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getAnalysis(userController.data.idUser!);
    super.initState();
  }

  Future<void> onRefresh() {
    return homeController.getAnalysis(userController.data.idUser!);
  }

  // Greeting based on local time
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
    // Drawer widget
    Widget drawer() {
      return Drawer(
        child: Column(
          children: [
            // Drawer header (name, email, logout button)
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                            // Get Email data from UserController
                            Obx(
                              () => Text(
                                userController.data.email ?? '',
                                style: blackTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add new transaction
            ListTile(
              onTap: () {
                // Check if data is null or not
                Get.to(() => AddHistoryPage())?.then((value) {
                  if (value ?? false) {
                    homeController.getAnalysis(userController.data.idUser!);
                  }
                });
              },
              leading: Icon(Icons.add_rounded, color: kPrimaryColor),
              horizontalTitleGap: 0,
              title: Text('Tambah Transaksi Baru', style: blackTextStyle),
              trailing: Icon(Icons.navigate_next_rounded, color: kPrimaryColor),
            ),
            const Divider(height: 1),
            // List income
            ListTile(
              onTap: () => Get.to(
                () => const IncomeOutcomePage(type: 'Pemasukan'),
              ),
              leading: Icon(Icons.south_west_rounded, color: kPrimaryColor),
              horizontalTitleGap: 0,
              title: Text('Pemasukan', style: blackTextStyle),
              trailing: Icon(Icons.navigate_next_rounded, color: kPrimaryColor),
            ),
            const Divider(height: 1),
            // List outcome
            ListTile(
              onTap: () => Get.to(
                () => const IncomeOutcomePage(type: 'Pengeluaran'),
              ),
              leading: Icon(Icons.north_east_rounded, color: kPrimaryColor),
              horizontalTitleGap: 0,
              title: Text('Pengeluaran', style: blackTextStyle),
              trailing: Icon(Icons.navigate_next_rounded, color: kPrimaryColor),
            ),
            const Divider(height: 1),
            // List history transaction
            ListTile(
              onTap: () {},
              leading: Icon(Icons.history_rounded, color: kPrimaryColor),
              horizontalTitleGap: 0,
              title: Text('Riwayat Transaksi', style: blackTextStyle),
              trailing: Icon(Icons.navigate_next_rounded, color: kPrimaryColor),
            ),
            const Divider(height: 1),
            // Logout Button
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: ListTile(
                  onTap: () async {
                    bool? yes = await DInfo.dialogConfirmation(
                      context,
                      'Keluar?',
                      'Anda Yakin Ingin Keluar?',
                    );
                    if (yes ?? false) {
                      SessionServices.deleteCurrentUser();
                      Get.to(() => const LoginPage());
                    }
                  },
                  leading: Icon(
                    Icons.logout_rounded,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Keluar',
                    style: blackTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

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
          Builder(
            builder: (context) {
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
            },
          ),
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
                          // Total today outcome
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                            child: Obx(
                              () => Text(
                                AppFormat.currencyFormat(
                                  homeController.today.toString(),
                                ),
                                style: whiteTextStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                          // Percentage outcome from yesterday
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Obx(
                              () => Text(
                                homeController.todayPercentage,
                                style: whiteTextStyle.copyWith(
                                  fontWeight: light,
                                ),
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
            child: Obx(
              () => DChartBar(
                data: [
                  {
                    'id': 'Bar',
                    'data': List.generate(
                      7,
                      (index) {
                        return {
                          'domain': homeController.weekData()[index],
                          'measure': homeController.week[index],
                        };
                      },
                    ),
                  },
                ],
                domainLabelPaddingToAxisLine: 8,
                axisLineTick: 2,
                axisLineColor: kPrimaryColor,
                measureLabelPaddingToAxisLine: 16,
                barColor: (barData, index, id) => kCyanColor,
                showBarValue: true,
              ),
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
                    Obx(
                      () => DChartPie(
                        data: [
                          {
                            'domain': 'income',
                            'measure': homeController.monthIncome
                          },
                          {
                            'domain': 'outcome',
                            'measure': homeController.monthOutcome
                          },
                          if (homeController.monthIncome == 0 &&
                              homeController.monthOutcome == 0)
                            {'domain': 'nol', 'measure': 1},
                        ],
                        fillColor: (pieData, index) {
                          switch (pieData['domain']) {
                            case 'income':
                              return kPrimaryColor;
                            case 'outcome':
                              return kCyanColor;
                            default:
                              return kWhiteColor;
                          }
                        },
                        donutWidth: 20,
                        labelColor: Colors.transparent,
                        showLabelLine: false,
                      ),
                    ),
                    Center(
                      child: Obx(
                        () => Text(
                          '${homeController.incomePercentage}%',
                          style: blueTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: light,
                          ),
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
                      homeController.monthPercentage,
                      style: blackTextStyle.copyWith(fontWeight: light),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    DView.spaceHeight(10),
                    RichText(
                      text: TextSpan(
                        text: 'Atau setara: \n',
                        style: blackTextStyle,
                        children: [
                          TextSpan(
                            text: AppFormat.currencyFormat(
                              homeController.differentMonth.toString(),
                            ),
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
      endDrawer: drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 24,
        ),
        child: Column(
          children: [
            header(),
            DView.spaceHeight(24),
            // Body (Outcome daily, weekly, monthly)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => onRefresh(),
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
            ),
          ],
        ),
      ),
    );
  }
}
