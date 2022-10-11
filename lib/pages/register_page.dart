import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring_devtest/pages/home_page.dart';
import 'package:moneytoring_devtest/services/source/user_source.dart';
import 'package:moneytoring_devtest/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  registration() async {
    if (formKey.currentState!.validate()) {
      // Collecting data response body after validating
      await UserSource.register(
        nameController.text,
        emailController.text,
        passController.text,
      );
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
                          // Name text field
                          TextFormField(
                            controller: nameController,
                            validator: (value) => value == ''
                                ? 'Harap Isi Nama Lengkap Anda'
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Nama Lengkap',
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
                              onPressed: () => registration(),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'DAFTAR',
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
                  // Back to Login TextButton
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah Punya Akun? ',
                          style: blackTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'Masuk',
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
