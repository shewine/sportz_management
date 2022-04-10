import 'package:flutter/widgets.dart';

import '../models/admin.dart';
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  // Admin? _admin;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;
  // Admin get getAdmin => _admin!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;

    notifyListeners();
  }

  // Future<void> refreshAdmin() async {
  //   Admin admin = await _authMethods.getAdminDetails();
  //   _admin = admin;
  //   notifyListeners();
  // }
}
