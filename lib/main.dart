import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/models/user_models.dart';
import 'package:moneytoring_devtest/pages/home_page.dart';
import 'package:moneytoring_devtest/pages/login_page.dart';
import 'package:moneytoring_devtest/services/session_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SessionServices.getCurrentUser(),
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          // Check if there is any session available
          if (snapshot.data != null && snapshot.data!.idUser != null) {
            // If user session is available go to HomePage
            return HomePage();
          }
          // If isn't go to LoginPage
          return LoginPage();
        },
      ),
    );
  }
}
