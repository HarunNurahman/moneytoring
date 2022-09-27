import 'package:get/get.dart';
import 'package:moneytoring/models/user_model.dart';

class UserController extends GetxController {
  final data = UserModel().obs;

  UserModel get getData => data.value;
  setData(n) => data.value = n;
}
