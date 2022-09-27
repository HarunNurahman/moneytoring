import 'package:intl/intl.dart';

class AppFormat {
  String dateFormat(String dateFormat) {
    DateTime dateTime = DateTime.parse(dateFormat);

    return DateFormat('DD MMM YYYY', 'id_ID').format(dateTime);
  }
}
