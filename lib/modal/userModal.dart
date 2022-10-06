import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String pass;
  final String email;
  final String id;
  final String phonenum;
  String proimg;

  UserData({
    this.id = "",
    this.email = "",
    this.name = "",
    this.pass = "",
    this.proimg = "",
    this.phonenum = "",
  });

  

  factory UserData.fromjson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return UserData(
        id: data["id"] ?? "",
        email: data["email"] ?? "",
        name: data["name"] ?? "",
        pass: data["pass"] ?? "",
        phonenum: data["phonenum"] ?? "",
        proimg: data["profileImg"] ?? "");
  }

  Map<String, dynamic> tomap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['pass'] = this.pass;
    data['phonenum'] = this.phonenum;
    data['profileImg'] = this.proimg;
    return data;
  }
}
