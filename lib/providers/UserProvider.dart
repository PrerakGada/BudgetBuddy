// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:budget_buddy/utils/shared_preference.dart';

import '../models/User.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    pullUser();
  }

  User _user = User();

  void pullUser() async {
    _user = await UserPreferences().getUser();
    notifyListeners();
  }

  User getUser() {
    if (kDebugMode) {
      print("returning user ${_user.profilePhoto}");
    }
    return _user;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}