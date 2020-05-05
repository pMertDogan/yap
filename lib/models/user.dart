import 'package:flutter/cupertino.dart';

class User {
  int id;
  String userName;
  String email;
  String photoURL;
  String photoLocal;

  User(
      {@required this.id,
      @required this.userName,
      @required this.email,
      this.photoURL,
      this.photoLocal});
}
