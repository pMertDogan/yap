import 'package:flutter/material.dart';
import 'package:todo/models/friend.dart';

class User {
  String id;
  String userName;
  String email;
  String photoURL;
  String photoLocal;
  //Used set for uniq but its not working on Friend class
  // :/ (I can add more than one same of the friend)
  Set<Friend> friends = <Friend>{};

  User(
      {@required this.id,
      @required this.userName,
      @required this.email,
      this.photoURL,
      this.photoLocal});
}
