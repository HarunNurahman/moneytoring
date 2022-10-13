import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddHistoryController extends GetxController {
  // Catch and contain transaction date
  final _date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String get date => _date.value;
  // Setter date
  setDate(n) => _date.value = n;

  // Catch and contain transaction type
  final _type = 'Pemasukan'.obs;
  String get type => _type.value;
  // Setter type
  setType(n) => _type.value = n;

  // Catch and contain transaction item
  final _item = [].obs;
  List get item => _item.value;
  // Add transaction item to box and update it
  addItem(n) {
    _item.value.add(n);
    setCount();
  }

  // Delete transaction item, using index
  deleteItem(i) {
    _item.value.removeAt(i);
    setCount();
  }

  // Count total transaction based on item
  final _total = 0.0.obs;
  double get total => _total.value;

  // Count function
  setCount() {
    _total.value = item.map((e) => e['value']).toList().fold(0.0,
        (previousValue, element) {
      return double.parse(previousValue.toString()) + double.parse(element);
    });
    update();
  }
}
