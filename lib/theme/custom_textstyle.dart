import 'package:flutter/material.dart';
import 'package:techtest/theme/app_colors.dart';

class Custom_TextStyle {
  static const appbarstyle = TextStyle(
      fontSize: 22,
      wordSpacing: 2,
      color: AppColors.black,
      letterSpacing: 2,
      fontWeight: FontWeight.w400);

  static const textStyle1 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 25);
  static const textStyle2 = TextStyle(color: AppColors.black, fontSize: 25);
  static const textStyle3 = TextStyle(color: AppColors.blue, fontSize: 18);

  static const textStyle4 = TextStyle(color: AppColors.black, fontSize: 14);
  static const textStyle5 = TextStyle(color: AppColors.grey, fontSize: 14);
  static const textStyle6 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.white, fontSize: 18);
  static const textStyle7 = TextStyle(
      color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold);
}
