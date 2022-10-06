import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest/controller/authController.dart';
import 'package:techtest/routes/pages.dart';
import 'package:techtest/theme/app_colors.dart';
import 'package:techtest/theme/app_string.dart';
import 'package:techtest/theme/custom_textstyle.dart';
import 'package:techtest/widget/logger.dart';

import '../../theme/custom_textfield.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;
  RxBool rxPassword = true.obs;
  RxBool rxIsLoading = false.obs;
  RxBool selectedvalue = false.obs;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    //email
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);

    //number
    String patttern = r'(^(?:[+0]9{10})?[0-9]{10}$)';
    RegExp regExp1 = new RegExp(patttern);

    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account ?",
              style: Custom_TextStyle.textStyle5,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(Routes.Signup);
                },
                child: Text(
                  "Sign Up",
                  style: Custom_TextStyle.textStyle3,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "immence",
                  style: Custom_TextStyle.textStyle1,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                      Text(
                  "Hi, Welcome Back! ",
                  style: Custom_TextStyle.textStyle2,
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: Image.network(AppString.slapicon,fit: BoxFit.fill,)),

                  ],
                ),
              
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email",
                  style: Custom_TextStyle.textStyle3,
                ),
                CustomTextField(
                    maxLine: 1,
                    filled: true,
                    enable: true,
                    controller: _email,
                    isCenter: false,
                    color: AppColors.black,
                    keyBoardType: TextInputType.emailAddress,
                    hintText: "Please Enter Your Email Address",
                    style: Custom_TextStyle.textStyle4,
                    onChanged: (value) {},
                    validator: (val) {
                      if (val!.length == 0)
                        return "Enter Your Email Address";
                      else if (!val.isEmail)
                        return "Enter Valid Email Address";
                      else if (!regExp.hasMatch(val)) {
                        return "Enter Valid Email Address";
                      }
                    },
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: Custom_TextStyle.textStyle3,
                ),
                Obx(
                  () => CustomTextField(
                      controller: _pass,
                      obscure: showPassword.value,
                      postFixIcon: GestureDetector(
                        child: !showPassword.value
                            ? Icon(Icons.remove_red_eye_outlined,
                                color: AppColors.grey)
                            : Icon(Icons.visibility_off_outlined,
                                color: AppColors.grey),
                        onTap: () {
                          showPassword.value = !showPassword.value;
                        },
                      ),
                      maxLine: 1,
                      filled: true,
                      enable: true,
                      isCenter: false,
                      color: AppColors.black,
                      keyBoardType: TextInputType.text,
                      hintText: "Please Enter Your Password",
                      style: Custom_TextStyle.textStyle4,
                      onChanged: (value) {},
                      validator: (val) {
                        if (val!.length == 0) return "Enter Your Password";
                      },
                      onFieldSubmitted: (String value) async {},
                      textInputAction: TextInputAction.done),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: selectedvalue.value,
                        onChanged: (bool? value) {
                          selectedvalue.value = value!;
                        },
                      ),
                    ),
                    Text("Remember Me"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Center(
                    child: Container(
                      width: Get.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.blue)),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              rxIsLoading.value = true;
                              try {
                                authController.signInAccount(
                                    _email.text, _pass.text);
                              } catch (e) {
                                logger.e(e);
                              }
      
                              rxIsLoading.value = false;
                            }
                          },
                          child: rxIsLoading.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ))
                              : Text(
                                  "Login",
                                  style:
                                  Custom_TextStyle.textStyle6,
                                )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
