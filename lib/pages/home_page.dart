import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/pages/login_page.dart';
import 'package:moneytoring_devtest/services/session_services.dart';
import 'package:moneytoring_devtest/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: blackTextStyle,
            ),
            DView.spaceWidth(),
            IconButton(
              onPressed: () {
                SessionServices.deleteCurrentUser();
                Get.off(() => const LoginPage());
              },
              icon: Icon(
                Icons.logout_outlined,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
