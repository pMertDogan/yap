import 'dart:io';

import 'package:todo/models/user.dart';

abstract class AuthBase {
  Future<User> singInWithEmailAndPass(String email, password);
  Future<User> singUpWithEmailAndPass(String email, password, name,
      {File userImage});
  Future<String> changeUserPhoto(File photo);
  bool passwordReset(String email) {}
  Future<User> getCurrentUser();
}
