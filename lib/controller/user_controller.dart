import 'package:get/get.dart';
import 'package:moneytoring_devtest/models/user_models.dart';

class UserController extends GetxController {
  // Get session value from Rx
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  setData(n) => _data.value = n;
}
