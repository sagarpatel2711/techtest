import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest/controller/authController.dart';
import 'package:techtest/routes/pages.dart';
import 'package:techtest/theme/app_colors.dart';
import 'package:techtest/theme/custom_textfield.dart';
import 'package:techtest/theme/custom_textstyle.dart';
import 'package:techtest/widget/logger.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _name = TextEditingController();
  RxBool selectedvalue = false.obs;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  RxBool rxIsLoading = false.obs;
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
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account ?",
              style: Custom_TextStyle.textStyle5,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(Routes.Login);
                },
                child: Text(
                  "Login",
                  style: Custom_TextStyle.textStyle3,
                )),
          ],
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
                  Text(
                    "Create an account",
                    style: Custom_TextStyle.textStyle2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name",
                    style: Custom_TextStyle.textStyle3,
                  ),
                  CustomTextField(
                      controller: _name,
                      maxLine: 1,
                      filled: true,
                      enable: true,
                      isCenter: false,
                      color: AppColors.black,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: "Enter Your Name",
                      style: Custom_TextStyle.textStyle4,
                      onChanged: (value) {
                        // authController.email_address = value.toString();
                      },
                      validator: (val) {
                        if (val!.length == 0) return "Enter Your Name";
                      },
                      textInputAction: TextInputAction.next),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Email",
                    style: Custom_TextStyle.textStyle3,
                  ),
                  CustomTextField(
                      controller: _email,
                      maxLine: 1,
                      filled: true,
                      enable: true,
                      isCenter: false,
                      color: AppColors.black,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: "Please Enter Your Email Address",
                      style: Custom_TextStyle.textStyle4,
                      onChanged: (value) {
                        // authController.email_address = value.toString();
                      },
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
                    height: 5,
                  ),
                  Text(
                    "Phone Number",
                    style: Custom_TextStyle.textStyle3,
                  ),
                  CustomTextField(
                      controller: _phonenumber,
                      maxLine: 1,
                      filled: true,
                      enable: true,
                      isCenter: false,
                      color: AppColors.black,
                      keyBoardType: TextInputType.number,
                      hintText: "Please Enter Your PhoneNumber",
                      style: Custom_TextStyle.textStyle4,
                      validator: (val) {
                        if (val!.length == 0) return "Enter Your Phone Number";
                          else if (!regExp1.hasMatch(val)) {
                          return "Enter Valid Phone number";
                        }
                      },
                      textInputAction: TextInputAction.next),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Password",
                    style: Custom_TextStyle.textStyle3,
                  ),
                  CustomTextField(
                      controller: _pass,
                      maxLine: 1,
                      filled: true,
                      enable: true,
                      isCenter: false,
                      color: AppColors.black,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: "Please Enter Your Password",
                      style: Custom_TextStyle.textStyle4,
                      validator: (val) {
                        if (val!.length == 0)
                          return "Enter Your Password";
                         
                       
                      },
                      textInputAction: TextInputAction.next),
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
                  Obx(
                    () => Center(
                      child: Expanded(
                        child: Container(
                          width: Get.width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.blue)),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  rxIsLoading.value = true;
                                  try {
                                    var val = await authController.createAccount(
                                      name: _name.text,
                                      email: _email.text,
                                      phonenum: _phonenumber.text,
                                      pass: _pass.text,
                                    );
                                    if (val) {
                                      Get.offNamed(Routes.Login);
                                      logger.i(val);
                                    }
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
                                      "Sign Up",
                                      style: Custom_TextStyle.textStyle6,
                                    )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
