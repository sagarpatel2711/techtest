import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techtest/widget/logger.dart';

class Storage {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      final imgfile = await storage.ref('userdata/$fileName').putFile(file);
      final String downloadUrl = await imgfile.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'profileImg': downloadUrl}, SetOptions(merge: true));
      return downloadUrl;
    } catch (e) {
      logger.d("Uploadfile : ${e}");
      return "";
    }
  }
}
