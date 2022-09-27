import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      home: Scaffold(),
    );
  }
}
