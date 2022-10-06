import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:techtest/modal/userModal.dart';
import 'package:techtest/widget/logger.dart';

final AuthModal auth = AuthModal();

class AuthModal extends GetxService {
  final _auth = FirebaseAuth.instance;
  final firebaseKey = FirebaseFirestore.instance;

  static final AuthModal _instance = AuthModal.internal();

  factory AuthModal() => _instance;

  AuthModal.internal();

  late final StreamSubscription<User?> userStream;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    userStream = _auth.authStateChanges().listen((event) async {
      logger.i(_auth.currentUser);
      if (event != null) {
        getUser(userData: event);
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    });
    super.onReady();
  }

  UserData user = UserData(id: "");

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? "";

  Future<void> logout() async {
    try {      
      FirebaseAuth.instance.signOut();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getUser({required User userData}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firebaseKey.collection('user').doc(userData.uid).get();
      if (doc.exists) {
        user = UserData.fromjson(doc);
      } else {
        user = UserData.fromjson(doc);
        await firebaseKey.collection('user').doc(userData.uid).set({
          'email': user.email,
          'name': user.name,
          'id': user.id,
          'pass': user.pass,
          'phonenum': user.phonenum,
          'profileImg': user.proimg,
        });
        logger.d("user email : ${user.email}");
      }
    } catch (e) {
      logger.e("Service.getUser", e);
    }
  }
}
