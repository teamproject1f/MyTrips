
import 'package:flutter/cupertino.dart';

class UserModel {
  String? email;
  String? name;
  String? uId;
  String? token;
  AssetImage? image;
  bool? isEmailVerified ;

  UserModel(
      {
        this.uId,
        this.token,
        this.name,
        this.email,
        this.image,
        this.isEmailVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    token = json['token'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'token': token,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}