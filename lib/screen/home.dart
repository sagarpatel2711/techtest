import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest/screen/auth/homeScreen.dart';
import 'package:techtest/screen/profileScreen.dart';
import 'package:techtest/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       bottomNavigationBar: bottomBar(context),
      body: Obx(
                          () => IndexedStack(
                            index: selectedIndex.value,
                            children: [
                             
                              HomeScreen(),
                               ProfileView(),
                             
                            
                            ],
                          ),
                        ),);
  }

  Color isSelected(int index) {
    if (selectedIndex.value == index) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  bottomBar(context) {
    return Obx(
      () => BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex.value,
        onTap: (int index) {
          selectedIndex.value = index;
        },
        backgroundColor: AppColors.white,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: AppColors.grey),
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
