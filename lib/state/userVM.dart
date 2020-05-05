import 'dart:io';

import 'package:todo/models/user.dart';
import 'package:todo/repo/authBase.dart';

class UserVM implements AuthBase {
  final AuthBase authService;

  UserVM(this.authService) {
    print("userVM created ");
  }

  User user;
  String registerLoginEmail;
  String registerLoginPassword;
  String registerLoginName;
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

  @override
  bool passwordReset(String email) {
    // TODO: implement passwordReset
    return null;
  }

  @override
  Future<User> singInWithEmailAndPass(String email, password) async {
    if (fieldsCheck()) {
      user = await authService.singInWithEmailAndPass(email, password);
    }
    return user;
  }

  @override
  Future<User> singUpWithEmailAndPass(String email, password, name,
      {File userImage}) async {
    File image = userImage ?? registerAvatar;
    if (fieldsCheck(registermode: true)) {
      user = await authService.singUpWithEmailAndPass(email, password, name,
          userImage: image);
      print("userVM UserName " + user.userName.toString());
    }
    return user;
  }

  @override
  Future<User> getCurrentUser() async {
    user = await authService.getCurrentUser();
    return user;
  }

  @override
  Future<String> changeUserPhoto(File photo) async {
    String photoURL = await authService.changeUserPhoto(photo);
    user.photoURL = photoURL;
    print("userVM user photo url " + user.photoURL);
    return photoURL;
  }
}
