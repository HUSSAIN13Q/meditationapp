import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditationapp/models/user.dart';
import 'package:meditationapp/services/auth_services.dart';
import 'package:meditationapp/services/client_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  final tokenKey = "token";

  // Signup method
  Future<void> signup(
      {required String username,
      required String password,
      required String imagePath}) async {
    notifyListeners();
    var token = await AuthServices()
        .signup(username: username, password: password, imagePath: imagePath);
    await _setToken(token);
    print(token);
    notifyListeners();
  }

  Future<bool> signin(
      {required String username, required String password}) async {
    try {
      var token =
          await AuthServices().signin(username: username, password: password);
      await _setToken(token);

      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> isLoggedFromStoreToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString(tokenKey);
    if (storedToken == null || storedToken.isEmpty) return false;

    if (Jwt.isExpired(storedToken)) return false;

    await _setToken(storedToken);

    return true;
  }

  Future<void> _setToken(String token) async {
    Client.dio.options.headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);

    user = User.fromJson(Jwt.parseJwt(token));
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(tokenKey) ?? "";
    Client.dio.options.headers["authorization"] = "Bearer $token";
    notifyListeners();
  }

  bool isAuth() => user != null;

  Future<void> initializeAuth() async {
    await _getToken();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    user = null;
    notifyListeners();
  }
}
