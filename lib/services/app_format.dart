import 'package:intl/intl.dart';

class AppFormat {
  String dateFormat(String dateFormat) {
    DateTime dateTime = DateTime.parse(dateFormat);

    return DateFormat('DD MMM YYYY', 'id_ID').format(dateTime);
  }

  static String currencyFormat(String number) {
    return NumberFormat.currency(
      decimalDigits: 0,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(double.parse(number));
  }
}
