import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/pages/home_page.dart';
import 'package:moneytoring_devtest/pages/register_page.dart';
import 'package:moneytoring_devtest/services/source/user_source.dart';
import 'package:moneytoring_devtest/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState!.validate()) {
      // Collecting data response body after validating
      bool success = await UserSource.login(
        emailController.text,
        passController.text,
      );
      if (success) {
        // ignore: use_build_context_synchronously
        DInfo.dialogSuccess(context, 'Login Berhasil');
        // ignore: use_build_context_synchronously
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        DInfo.toastError('Gagal Login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  // Header (app logo, email textfield, password textfield)
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAssets.appLogo),
                          DView.spaceHeight(40),
                          // Email text field
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                value == '' ? 'Harap Isi Email Anda' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: whiteTextStyle.copyWith(
                                color: kWhiteColor.withOpacity(0.5),
                              ),
                              isDense: true,
                              fillColor: kPrimaryColor.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                            style: whiteTextStyle.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                          DView.spaceHeight(), // 16
                          // Password text field
                          TextFormField(
                            controller: passController,
                            validator: (value) =>
                                value == '' ? 'Harap Isi Password Anda' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: whiteTextStyle.copyWith(
                                color: kWhiteColor.withOpacity(0.5),
                              ),
                              isDense: true,
                              fillColor: kPrimaryColor.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                            style: whiteTextStyle.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                          DView.spaceHeight(24), // 16
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => login(),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'MASUK',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Register TextButton
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum Punya Akun? ',
                          style: blackTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: Text(
                            'Register',
                            style: blueTextStyle.copyWith(
                              fontWeight: semiBold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
