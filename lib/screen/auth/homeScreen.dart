import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest/controller/authController.dart';
import 'package:techtest/modal/authModal.dart';
import 'package:techtest/modal/userModal.dart';
import 'package:techtest/theme/custom_textstyle.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  UserData userData = UserData();
  AuthController authController = Get.put(AuthController());
  
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              "Users",
              style: Custom_TextStyle.textStyle2,
            ),
            
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              builder: (context, snapshot) {
                List<UserData> userdata = [];
                userdata.addAll(
                    snapshot.data!.docs.map((item) => UserData.fromjson(item)));

                return Expanded(
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: userdata.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text("${userData.name}",style: Custom_TextStyle.textStyle7,),
                            subtitle: Text("${userData.email}",style: Custom_TextStyle.textStyle5,),

                         
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
