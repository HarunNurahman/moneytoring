import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// App Color
Color kPrimaryColor = const Color(0xFF767AE7);
Color kBlueColor = const Color(0xFF9AB3F5);
Color kCyanColor = const Color(0xFFB9FFFC);
Color kBlackColor = const Color(0xFF1F1F1F);
Color kWhiteColor = const Color(0xFFFFFFFF);

// App TextStyle
TextStyle blackTextStyle = GoogleFonts.poppins(color: kBlackColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: kWhiteColor);
TextStyle blueTextStyle = GoogleFonts.poppins(color: kPrimaryColor);
TextStyle cyanTextStyle = GoogleFonts.poppins(color: kCyanColor);

// App FontWeight
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

// App Assets
class AppAssets {
  static const appLogo = 'assets/img_app-logo.png';
  static const imgProfile = 'assets/img_profile.png';
}
