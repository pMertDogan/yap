import 'dart:io';
import 'dart:math';

import 'package:todo/data/base/authBase.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/user.dart';

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
    user = User(id: Random().nextInt(763), email: email, name: name);
    user.friends
        .add(Friend(id: 70, userName: "Abra Denk", email: "ayla@mail.co"));
    user.friends.add(Friend(id: 71, userName: "Mert", email: "ayla@mail.co"));
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

  @override
  Future<void> addFriend(Friend friend) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }
}
