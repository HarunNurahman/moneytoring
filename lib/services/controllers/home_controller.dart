import 'package:get/get.dart';
import 'package:moneytoring/services/sources/transaction_sources.dart';

class HomeController extends GetxController {
  final _todayTransaction = 0.0.obs;
  double get todayTransaction => _todayTransaction.value;

  final _todayPercentage = ''.obs;
  String get todayPercentage => _todayPercentage.value;

  final _weeklyTransaction = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  List<double> get weeklyTransaction => _weeklyTransaction.value;

  List<String> get days => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> week() {
    DateTime today = DateTime.now();
    return [
      days[today.subtract(const Duration(days: 6)).weekday - 1],
      days[today.subtract(const Duration(days: 5)).weekday - 1],
      days[today.subtract(const Duration(days: 4)).weekday - 1],
      days[today.subtract(const Duration(days: 3)).weekday - 1],
      days[today.subtract(const Duration(days: 2)).weekday - 1],
      days[today.subtract(const Duration(days: 1)).weekday - 1],
      days[today.weekday - 1]
    ];
  }

  final _monthlyIncome = 0.0.obs;
  double get monthlyIncome => _monthlyIncome.value;

  final _monthlyOutcome = 0.0.obs;
  double get monthlyOutcome => _monthlyOutcome.value;

  final _incomePercentage = '0'.obs;
  String get incomePercentage => _incomePercentage.value;

  final _monthlyPercentage = ''.obs;
  String get monthlyPercentage => _monthlyPercentage.value;

  final _differentMonth = 0.0.obs;
  double get differentMonth => _differentMonth.value;

  getAnalysis(String idUser) async {
    Map data = await TransactionSource.analysis(idUser);

    _todayTransaction.value = data['today'].toDouble();
    double yesterday = data['yesterday'].toDouble();
    double different = (todayTransaction - yesterday).abs();
    bool isSame = todayTransaction.isEqual(yesterday);
    bool isPlus = todayTransaction.isGreaterThan(yesterday);
    double byYesterday = yesterday == 0 ? 1 : yesterday;
    double percentage = (different / byYesterday) * 100;

    _todayPercentage.value = isSame
        ? '100% sama dengan kemarin'
        : isPlus
            ? '+${percentage.toStringAsFixed(1)}% dibanding kemarin'
            : '-${percentage.toStringAsFixed(1)}% dibanding kemarin';

    _weeklyTransaction.value =
        List.castFrom(data['week'].map((e) => e.toDouble()).toList());

    _monthlyIncome.value = data['month']['income'].toDouble();
    _monthlyOutcome.value = data['month']['outcome'].toDouble();
    _differentMonth.value = (monthlyIncome - monthlyOutcome).abs();
    bool isSameMonth = monthlyIncome.isEqual(monthlyOutcome);
    bool isPlushMonth = monthlyIncome.isGreaterThan(monthlyIncome);
    double byOutcome = monthlyOutcome == 0 ? 1 : monthlyIncome;
    double monthlyPercentage = (differentMonth / byOutcome) * 100;
    _incomePercentage.value =
        ((differentMonth / byOutcome) * 100).toStringAsFixed(1);
    _monthlyPercentage.value = isSameMonth
        ? 'Pemasukan\n100% sama\ndengan Pengeluaran'
        : isPlushMonth
            ? 'Pemasukan\nlebih besar ${monthlyPercentage.toStringAsFixed(1)}% dari Pengeluaran'
            : 'Pemasukan\nlebih kecil ${monthlyPercentage.toStringAsFixed(1)}% dari Pengeluaran';
  }
}
