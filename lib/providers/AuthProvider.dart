import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/User.dart';
import '../utils/api_url.dart';
import '../utils/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  AuthProvider() {
    Timer.periodic(Duration(minutes: 4), (timer) {
      refreshToken();
    });
  }

  Future<bool> logout() async {
    UserPreferences().removeUser();
    _loggedInStatus = Status.NotLoggedIn;
    notifyListeners();
    return true;
  }

  Future<void> refreshToken() async {
    User user = await UserPreferences().getUser();
    if (user.refreshToken != '') {
      print("Token refreshed");
      final Map<String, dynamic> refreshTokenData = {
        'refresh': user.refreshToken
      };

      Response response = await post(
        Uri.parse(AppUrl.refresh),
        body: json.encode(refreshTokenData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> data =
            JwtDecoder.decode(responseData['access']);

        user.accessToken = responseData['access'];
        user.refreshToken = responseData['refresh'];
        user.userId = data['user_id'];
        user.email = data['email'];
        user.emailVerified = data['email_verified'].toString();
        user.profilePhoto = AppUrl.domainURL + data['profile_photo'].toString();
        print(user.profilePhoto);
        UserPreferences().saveUser(user);
      } else {
        print("refresh token failed");
        logout();
        print(response.body);
        print(response.statusCode);
      }
    } else {
      print("Refresh token is null");
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    print("Login function called");

    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    late Map<String, dynamic> userData = {};

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    print(Uri.parse(AppUrl.login));

    try {
      Response response = await post(
        Uri.parse(AppUrl.login),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> data =
            JwtDecoder.decode(responseData['access']);

        print(
            "Access token in login function auth provider: ${responseData['access']}");

        userData["accessToken"] = responseData['access'];
        userData["refreshToken"] = responseData['refresh'];
        userData["userId"] = data['user_id'];
        userData["email"] = data['email'];
        userData["emailVerified"] = data['email_verified'];
        userData["userName"] = data['username'];
        userData["profilePhoto"] = AppUrl.domainURL + data['profile_photo'];



        print("User data in login function auth provider: ${userData}");

        User authUser = User.fromJson(userData);
        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else if (response.statusCode == 401) {
        print("login failed");
        print(response.statusCode);
        _loggedInStatus = Status.NotLoggedIn;

        notifyListeners();
        return result = {
          'status': false,
          'message': 'User not found. Please check your email and password.'
        };
      } else if (response.statusCode == 502) {
        print("login failed");
        print(response.statusCode);
        _loggedInStatus = Status.NotLoggedIn;

        notifyListeners();
        return result = {
          'status': false,
          'message': 'Login is currently unavailable, please try again later.'
        };
      } else {
        print("login failed");
        print(response.statusCode);
        _loggedInStatus = Status.NotLoggedIn;

        notifyListeners();
        return result = {
          'status': false,
          'message':
              'Something unexpected has happened, contact support if the issue persists.'
        };
      }
    } on SocketException catch (_) {
      print("No internet");
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      return result = {
        'status': false,
        'message': 'Something went wrong. Please check your internet connection'
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String password1, String password2) async {
    print("Register function called");
    Map<String, dynamic> result;
    late Map<String, dynamic> userData = {};

    final Map<String, dynamic> registrationData = {
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    Response response = await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> data =
          JwtDecoder.decode(responseData['access_token']);

      print(data);

      userData["accessToken"] = responseData['access_token'];
      userData["refreshToken"] = responseData['refresh_token'];
      userData["userId"] = data['user_id'];
      userData["email"] = data['email'];
      userData["emailVerified"] = 'false';
      userData["userName"] = data['username'];
      userData["profilePhoto"] = AppUrl.domainURL + data['profile_photo'];

      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser);
      refreshToken();

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else if (response.statusCode == 400) {
      final responseData = json.decode(response.body);
      print('Registration failed');
      print(responseData);
      result = {
        'status': false,
      };
      if (json.decode(response.body)['email'] != null) {
        result['emailError'] = responseData['email'][0].toString();
      }
      if (json.decode(response.body)['username'] != null) {
        result['usernameError'] = responseData['username'][0].toString();
      } 
      if (json.decode(response.body)['password1'] != null) {
        result['passwordError'] = responseData['password1'][0].toString();
      } 
    } else {
      print("login failed");
      print(response.statusCode);
      print(response.body);
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<bool> checkEmailVerification() async {
    await refreshToken();
    User user = await UserPreferences().getUser();
    if (user.emailVerified == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> resendEmailVerification() async {
    final user = await UserPreferences().getUser();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };

    final body = {
      'email': '${user.email}',
    };

    Response response =
        await post(Uri.parse(AppUrl.resendEmailVerification), headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      return {'status': true, 'message': 'Successful'};
    } else {
      return {'status': false, 'message': 'Unsuccessful Request'};
    }
    
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'email': '$email',
    };

    Response response =
        await post(Uri.parse(AppUrl.forgotPassword), headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      return {'status': true, 'message': 'Successful'};
    } else {
      return {'status': false, 'message': 'Unsuccessful Request'};
    }
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
