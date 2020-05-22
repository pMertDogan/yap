import 'dart:io';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/user.dart';
import 'package:todo/data/base/authBase.dart';

class UserVM implements AuthBase {
  //Cloud
  final AuthBase authService;
  //Local sqflite
  final DatabaseHelper databaseHelper;

  UserVM(this.authService, this.databaseHelper) {
    print("userVM created ");
  }

  User user;
  // TODO remove this test credentials
  String registerLoginEmail = "test@test.co";
  String registerLoginPassword = "oasdasdads";
  String registerLoginName = "Test User";
  File registerAvatar;

  bool fieldsCheck({bool registermode = false}) {
    if (registermode) {
      return registerLoginEmail != null &&
          registerLoginPassword != null &&
          registerLoginName != null;
    } else {
      return registerLoginEmail != null && registerLoginPassword != null;
    }
  }

  Future<void> singOut() async {
    await databaseHelper.singOut();
    user = await databaseHelper.getCurrentUser();
    print("singout User: " + user.toString());
  }

  @override
  bool passwordReset(String email) {
    // TODO: implement passwordReset
    return null;
  }

  @override
  Future<User> singIn(String email, password) async {
    if (fieldsCheck()) {
      user = await authService.singIn(email, password);
    }
    return user;
  }

  @override
  Future<User> singUp(String email, password, name, {File userImage}) async {
    //check userImage if empty => try user registerAVATAR
    File image = userImage ?? registerAvatar;

    //Check all required fields
    if (fieldsCheck(registermode: true)) {
      User u;
      //Start sing up process
      u = await authService.singUp(email, password, name, userImage: image);

      databaseHelper.saveUser(u);
      user = u;
    }
    return user;
  }

  @override
  Future<User> getCurrentUser() async {
    user = await databaseHelper.getCurrentUser();
    //Cloud auth
    //user = await authService.getCurrentUser();
    return user;
  }

  @override
  Future<String> changeUserPhoto(File photo) async {
    String photoURL = await authService.changeUserPhoto(photo);

    //TODO Update local sqflite
    user.photoURL = photoURL;
    return photoURL;
  }
}
