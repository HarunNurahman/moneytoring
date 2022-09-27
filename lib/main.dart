import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring/models/user_model.dart';
import 'package:moneytoring/pages/home_page.dart';
import 'package:moneytoring/pages/login_page.dart';
import 'package:moneytoring/services/session.dart';
import 'package:moneytoring/shared/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
        ),
      ),
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.data != null && snapshot.data!.idUser != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
