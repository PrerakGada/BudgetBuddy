import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print("User is: ${user.toString()} in shared preferences");
    // print(user.accessToken);
    prefs.setInt("userId", user.userId ?? 0);
    prefs.setString("email", user.email ?? '');
    prefs.setString("accessToken", user.accessToken ?? '');
    prefs.setString("refreshToken", user.refreshToken ?? '');
    prefs.setString("emailVerified", user.emailVerified ?? '');
    prefs.setString("userName", user.userName ?? '');
    prefs.setString("profilePhoto", user.profilePhoto ?? '');
    return true;
  }

  Future<User> getUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId") ?? 0;
    String email = prefs.getString("email") ?? "";
    String refreshToken = prefs.getString("refreshToken") ?? "";
    String accessToken = prefs.getString("accessToken") ?? "";
    String emailVerified = prefs.getString("emailVerified") ?? "";
    String userName = prefs.getString("userName") ?? "";
    String profilePhoto = prefs.getString("profilePhoto") ?? "";
    
    

    return User(
        userId: userId,
        email: email,
        refreshToken: refreshToken,
        accessToken: accessToken,
        emailVerified: emailVerified,
        userName: userName,
        profilePhoto: profilePhoto,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("refreshToken");
    prefs.remove("accessToken");
    prefs.remove("emailVerified");
    prefs.remove("userName");
    prefs.remove("profilePhoto");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    return token ?? "";
  }
}