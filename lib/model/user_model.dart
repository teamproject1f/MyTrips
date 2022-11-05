
import 'package:flutter/cupertino.dart';

class UserModel {
  String? email;
  String? name;
  String? uId;
  String? token;
  AssetImage? image;


  UserModel(
      {
        this.uId,
        this.token,
        this.name,
        this.email,
        this.image,

      });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    token = json['token'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'token': token,
      'image': image,
    };
  }
}