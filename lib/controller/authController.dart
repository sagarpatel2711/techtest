import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:techtest/modal/userModal.dart';
import 'package:techtest/routes/pages.dart';
import 'package:techtest/storage/storage.dart';
import 'package:techtest/widget/logger.dart';

import '../modal/authModal.dart';

class AuthController extends GetxController {
  late Rx<User?> firebaseUser;
  UserData userData = UserData();
  final _gsauth = FirebaseAuth.instance;
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  final instance = FirebaseAuth.instance;
  late StreamSubscription userChange;

  Future<void> signInAccount(String email, String pass) async {
    try {
      await _gsauth.signInWithEmailAndPassword(email: email, password: pass);
      Get.offNamed(Routes.HOME);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> createAccount(
      {required String name,
      required String phonenum,
      required String email,
      required String pass}) async {
    try {
      UserCredential newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: pass.trim());

      if (newUser.user != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(newUser.user!.uid)
            .set({
          "name": name,
          "email": email,
          "phonenum": phonenum,
          "pass": pass
        });

        Get.offNamed(Routes.Login);
        logger.i("user email: ${email}");
        logger.i("user pass: ${pass}");
        update();
        return true;
      }
    } catch (error) {
      logger.e(error);
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(Routes.Login);
      update();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> uploadimg(String img) async {
    auth.user.proimg = img;
    logger.i("ProfileImg : ${auth.user.proimg}");
    update();
    auth.user.proimg = await Storage.uploadFile(
      img,
      DateTime.now().toString(),
    );
  }
}
