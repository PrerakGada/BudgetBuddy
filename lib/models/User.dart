// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

class User {
  int? userId;
  String? email;
  String? accessToken;
  String? refreshToken;
  String? emailVerified;
  String? profilePhoto;
  String? userName;
  List<Skills>? skills = [];



  User({this.userId, this.email, this.accessToken, this.refreshToken, this.emailVerified, this.userName, this.profilePhoto, this.skills});

  factory User.fromJson(Map<String, dynamic> responseData) {

    if (kDebugMode) {
      print("User data in user.dart: $responseData");
    }
    return User(
        userId: responseData['userId'],
        userName: responseData['userName'],
        profilePhoto: responseData['profilePhoto'],
        email: responseData['email'],
        accessToken: responseData['accessToken'],
        refreshToken: responseData['refreshToken'],
        emailVerified: responseData['emailVerified'].toString(),
        skills: responseData['skills'] != null ? List<Skills>.from(responseData['skills'].map((x) => Skills.fromJson(x))) : null        
    );
  }
}

class Skills {
  int skillId;
  String skillName;

  Skills({required this.skillId, required this.skillName});

  factory Skills.fromJson(Map<String, dynamic> responseData) {
    return Skills(
        skillId: responseData['id'],
        skillName: responseData['name']
    );
  }
}

class SkillOptions {
  int skillId;
  String skillName;
  String skillPhoto;

  SkillOptions({required this.skillId, required this.skillName, required this.skillPhoto});

  factory SkillOptions.fromJson(Map<String, dynamic> responseData) {
    return SkillOptions(
        skillId: responseData['skillid'],
        skillName: responseData['skillname'],
        skillPhoto: responseData['skillphoto']
    );
  }
}