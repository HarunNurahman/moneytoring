import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytoring/services/sources/user_sources.dart';
import 'package:moneytoring/shared/styles.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  register() async {
    if (formKey.currentState!.validate()) {
      await UserSource.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img_app-logo.png',
                            width: 108,
                          ),
                          DView.spaceHeight(60),
                          // Name Text Field
                          TextFormField(
                            controller: _nameController,
                            validator: (value) =>
                                value == '' ? 'Nama Harap Diisi!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'nama',
                              hintStyle: blueTextStyle,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              fillColor: kPrimaryColor.withOpacity(0.25),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          DView.spaceHeight(20),
                          // Email Text Field
                          TextFormField(
                            controller: _emailController,
                            validator: (value) =>
                                value == '' ? 'Email Harap Diisi!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'email',
                              hintStyle: blueTextStyle,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              fillColor: kPrimaryColor.withOpacity(0.25),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          DView.spaceHeight(20),
                          // Password Text Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) =>
                                value == '' ? 'Password Harap Diisi!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: blueTextStyle,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              fillColor: kPrimaryColor.withOpacity(0.25),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          DView.spaceHeight(40),
                          // register Button
                          Material(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                register();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 16,
                                ),
                                child: Text(
                                  'Register',
                                  style: whiteTextStyle,
                                ),
                              ),
                            ),
                          ),
                          DView.spaceHeight(30)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Sudah Punya Akun? ',
                            style: blackTextStyle,
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: blueTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontWeight: bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
