import 'package:flutter/material.dart';

class Friend {
  String id;
  String userName;
  String email;
  String photoURL;
  String photoLocal;

  Friend({@required this.id, @required this.userName, @required this.email});

  @override
  String toString() {
    return " Friend id:${this.id} UserName ${this.userName}";
  }
}
