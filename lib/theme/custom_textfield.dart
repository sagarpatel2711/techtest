import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techtest/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onChanged,
      this.hintText,
      this.obscure = false,
      this.validator,
      this.onSaved,
      this.color,
      this.keyBoardType,
      this.initialValue,
      this.maxLine,
      this.maxLength,
      this.controller,
      this.inputFormatters,
      this.priFixIcon,
      this.postFixIcon,
      this.enable,
      this.isCenter,
      this.textDirection,
      this.hintColor = AppColors.grey,
      this.styleColor,
      this.labelColor = AppColors.black,
      this.readOnly,
      this.textInputAction,
      this.infoView,
      this.onFieldSubmitted,
      this.focusNode,
      this.focusBorderColor = AppColors.blue,
      this.filled,
      this.fillColor = AppColors.white,
      this.borderColor = AppColors.black,
      this.enabledColor = AppColors.black,
      this.cursorColor = AppColors.black,
      this.borderredious = 8,
      this.style});

  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;

  final String? hintText;

  final bool obscure;
  final FormFieldValidator<String>? validator;
  final Color? color; //color apvo pdse ahi
  final Color cursorColor;
  final TextInputType? keyBoardType;
  final String? initialValue;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? priFixIcon;
  final Widget? postFixIcon;
  final bool? enable;
  final bool? isCenter;
  final TextDirection? textDirection;
  final Color hintColor;
  final Color? styleColor;
  final Color labelColor;
  final Color focusBorderColor;
  final Color borderColor;
  final Color enabledColor;
  final Color fillColor;
  final bool? readOnly;
  final bool? filled;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final Widget? infoView;
  final FocusNode? focusNode;
  final double borderredious;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        textAlign:
            isCenter != null && isCenter! ? TextAlign.center : TextAlign.left,
        readOnly: readOnly ?? false,
        enabled: enable == null ? true : enable,
        onChanged: onChanged,
        maxLength: maxLength,
        controller: controller,
        maxLines: maxLine,
        initialValue: initialValue,
        keyboardType: keyBoardType,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscure,
        inputFormatters: inputFormatters,
        textDirection: textDirection != null ? textDirection : null,
        style: style,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 14, color: AppColors.black),
          filled: filled,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          hintStyle: Get.textTheme.subtitle2!.copyWith(
            fontSize: kIsWeb ? 16 : 14,
            color: AppColors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderredious),
            borderSide: BorderSide(
              color: focusBorderColor,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderredious),
            borderSide: BorderSide(
              color: enabledColor,
              width: 0.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderredious),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 0.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderredious),
            borderSide: BorderSide(
              color: borderColor,
              width: 0.5,
            ),
          ),
          prefixIcon: priFixIcon,
          suffixIcon: postFixIcon == null
              ? null
              : IconTheme(
                  data: IconThemeData(color: color),
                  child: postFixIcon!,
                ),
        ),
      ),
    );
  }
}
