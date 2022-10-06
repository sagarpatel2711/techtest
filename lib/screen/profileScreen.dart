import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest/controller/authController.dart';
import 'package:techtest/theme/app_colors.dart';
import 'package:techtest/theme/custom_textstyle.dart';
import 'package:techtest/widget/logger.dart';

import '../modal/authModal.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController());
  String cCode = "+91";

  void selectImg(context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image")));
      return null;
    }
    final path = result.files.single.path!;
    final fileName = result.files.single.name;
    logger.i("image Path : ${path}");
    logger.i("image name : ${fileName}");
    authController.uploadimg(result.files.single.path!);
    logger.i("user prof :  ${auth.user.proimg}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage: auth.user.proimg.isNotEmpty
                            ? auth.user.proimg.contains("firebasestorage")
                                ? NetworkImage(auth.user.proimg)
                                : FileImage(File(auth.user.proimg))
                                    as ImageProvider
                            : AssetImage("assets/img/person1.png"),
                      ),
                      IconButton(
                          onPressed: () => selectImg(context),
                          icon: Icon(Icons.camera_alt_outlined))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${auth.user.name}",
                    style: Custom_TextStyle.textStyle1,
                  ),
                  Card(
                    child: ListTile(
                      leading: Text("Email"),
                      trailing: Text(
                        auth.user.email,
                        style: Custom_TextStyle.textStyle3,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Text("Phone No."),
                      trailing: Text(
                        "${cCode} ${auth.user.phonenum}",
                        style: Custom_TextStyle.textStyle3,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: (() {
                        authController.logout();
                      }),
                      leading: Text("Log out"),
                      trailing: Icon(Icons.logout, color: AppColors.blue),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
