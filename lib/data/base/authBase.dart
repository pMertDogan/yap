import 'dart:io';

import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/user.dart';

abstract class AuthBase {
  Future<User> singIn(String email, password);
  Future<User> singUp(String email, password, name, {File userImage});
  Future<String> changeUserPhoto(File photo);
  bool passwordReset(String email);
  Future<User> getCurrentUser();
  Future<void> addFriend(Friend friend);
}
