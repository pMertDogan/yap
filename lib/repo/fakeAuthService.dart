import 'dart:io';
import 'dart:math';

import 'package:todo/models/user.dart';
import 'package:todo/repo/authBase.dart';

class FakeAuthService implements AuthBase {
  User user;

  @override
  bool passwordReset(String email) {
    // TODO: implement passwordReset
    return null;
  }

  @override
  Future<User> getCurrentUser() async {
    await Future.delayed(Duration(seconds: 1));
    return user;
  }

  @override
  Future<User> singInWithEmailAndPass(String email, password) async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception("Sory, its not avaible to use");
    return user;
  }

  @override
  Future<User> singUpWithEmailAndPass(String email, password, name,
      {File userImage}) async {
    await Future.delayed(Duration(seconds: 1));
    user = User(id: 0.toString(), email: email, userName: name);
//    print("fakeAuth  userName " + user.userName.toString());
    if (userImage != null) {
      user.photoURL = await changeUserPhoto(userImage);
    }
    return user;
  }

  @override
  Future<String> changeUserPhoto(File photo) async {
    //int id = user.id;
    await Future.delayed(Duration(seconds: 2));
    String fakeURL =
        "https://picsum.photos/id/${Random().nextInt(50)}/300/300"; //70/70
    print("fake auth fakeurl " + fakeURL);
    return fakeURL;
  }
}
