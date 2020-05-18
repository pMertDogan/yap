import 'dart:io';
import 'dart:math';

import 'package:todo/data/models/user.dart';
import 'package:todo/data/base/authBase.dart';

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
  Future<User> singIn(String email, password) async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception("Sory, its not avaible to use");
    //return user;
  }

  @override
  Future<User> singUp(String email, password, name, {File userImage}) async {
    //should be Transaction singUp + image upload
    //Fake delay
    await Future.delayed(Duration(seconds: 1));
    //Generate fake user
    user = User(id: 1, email: email, name: name);
    //Upload user photo and change it
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
