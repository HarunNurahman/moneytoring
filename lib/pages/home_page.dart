import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:moneytoring/pages/login_page.dart';
import 'package:moneytoring/services/session_services.dart';
import 'package:moneytoring/shared/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: blackTextStyle,
            ),
            IconButton(
              onPressed: () {
                Session.deleteUser();
                Get.off(() => LoginPage());
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 32,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
