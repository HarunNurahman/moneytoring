import 'package:get/get.dart';
import 'package:moneytoring_devtest/services/source/history_source.dart';

class HomeController extends GetxController {
  // Catch Today data
  final _today = 0.0.obs;
  double get today => _today.value;
  // Today value percentage
  final _todayPercentage = '0'.obs;
  String get todayPercentage => _todayPercentage.value;

  // Catch Week data
  final _week = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  List<double> get week => _week.value;
  // List String days for bar chart
  // Save to List
  List<String> get days => [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ];
  // Generate arrangement of day
  List<String> weekData() {
    // Get today data
    // If we got weekday value, subtraction weekday - 1
    DateTime today = DateTime.now();
    // 6th day until today / descending order
    return [
      days[today.subtract(const Duration(days: 6)).weekday - 1],
      days[today.subtract(const Duration(days: 5)).weekday - 1],
      days[today.subtract(const Duration(days: 4)).weekday - 1],
      days[today.subtract(const Duration(days: 3)).weekday - 1],
      days[today.subtract(const Duration(days: 2)).weekday - 1],
      days[today.subtract(const Duration(days: 1)).weekday - 1],
      days[today.weekday - 1],
    ];
  }

  // Catch Monthly data
  // Contain data for pie chart
  // Monthly Income
  final _monthIncome = 0.0.obs;
  double get monthIncome => _monthIncome.value;
  // Monthly Outcome
  final _monthOutcome = 0.0.obs;
  double get monthOutcome => _monthOutcome.value;
  // Income monthly percentage
  final _incomePercentage = '0'.obs;
  String get incomePercentage => _incomePercentage.value;
  // Monthly percentage
  final _monthPercentage = ''.obs;
  String get monthPercentage => _monthPercentage.value;
  // Different income and outcome
  final _differentMonth = 0.0.obs;
  double get differentMonth => _differentMonth.value;

  /* ====================== Daily ====================== */
  // Get data from HistorySource
  getAnalysis(String idUser) async {
    Map data = await HistorySource.analysis(idUser);
    // Today outcome
    _today.value = data['today'].toDouble();
    // Yesteday outcome value
    double yesterday = data['yesterday'].toDouble();
    // Comparison outcome total from today and yesterday
    double different = (today - yesterday).abs();
    // Check if total outcome from today and yesterday is same
    bool isSame = today.isEqual(yesterday);
    // Check if total outcome from today is greater or less than yesterday
    bool isPlus = today.isGreaterThan(yesterday);
    // Divider from different or range from today and yesterday
    // Check if there is default value (0) and change it to (1)
    double dividerToday = (today + yesterday) == 0 ? 1 : (today + yesterday);
    // Calculate percetage
    double percentage = (different / dividerToday) * 100;
    // Showing today and yesterday percentage result
    _todayPercentage.value = isSame
        ? '100% sama dengan kemarin' // If today outcome and yesterday is same
        : isPlus
            ? '+${percentage.toStringAsFixed(1)}% dibanding kemarin' // If today outcome is greater than yesterday
            : '-${percentage.toStringAsFixed(1)}% dibanding kemarin'; // if today outcome is less than yesterday
    /* =================================================== */

    /* ====================== Weekly ====================== */
    // Showing weekly outcome value as array
    _week.value = List<double>.from(
      data['week'].map((e) => e.toDouble()).toList(),
    );
    /* ==================================================== */

    /* ====================== Monthly ====================== */
    // Get value income
    _monthIncome.value = data['month']['income'].toDouble();
    // Get value outcome
    _monthOutcome.value = data['month']['outcome'].toDouble();
    // Comparison income and outcome in 1 month
    _differentMonth.value = (monthIncome - monthOutcome).abs();
    // Check if income or outcome in 1 month is equal
    bool isSameMonth = monthIncome.isEqual(monthOutcome);
    // Check if income greater than outcome and vice versa in 1 month
    bool isPlusMonth = monthIncome.isGreaterThan(monthOutcome);
    // Divider from different or range from income and outcome
    // Check if there is default value (0) and change it to (1)
    double dividerMonth =
        (monthIncome + monthOutcome) == 0 ? 1 : (monthIncome + monthOutcome);
    // Calculate percetage
    double monthlyPercetage = (differentMonth / dividerMonth) * 100;
    // Income percentage for piechart
    _incomePercentage.value = monthlyPercetage.toStringAsFixed(1);
    // Percentage comparison result
    _monthPercentage.value = isSameMonth
        ? 'Pemasukan 100% sama dengan Pengeluaran'
        : isPlusMonth
            ? "Pemasukan lebih besar +$incomePercentage% dari Pengeluaran"
            : "Pemasukan lebih kecil -$incomePercentage% dari Pengeluaran ";
  }
  /* ======================================================*/
}
