import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
   String? _token;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url =  Uri.https('https://identitytoolkit.com/v1/accounts:$urlSegment?key=""');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
   debugPrint(responseData);
    _token = responseData['idToken'];
   debugPrint('************************$_token');
    try {
      if (urlSegment == "signUp") {
        sharedPreferences.setString("token", _token.toString());
      }
    } catch (e) {
     if (kDebugMode) {
       print(e);
     }
    }
   debugPrint("true");
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> changePassword(String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString("token")!;
    var  url =  Uri.https('https://identitytoolkit.googleapis.com/v1/accounts:update?key=""');
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
