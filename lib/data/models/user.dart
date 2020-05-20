import 'package:flutter/material.dart';
import 'package:todo/data/models/friend.dart';

class User {
  int id;
  String name;
  String email;
  String photoURL;
  String photoLocal;

  //Used set for uniq but its not working on Friend class
  // :/ (I can add more than one same of the friend)
  Set<Friend> friends = <Friend>{};

  User(
      {@required this.id,
      @required this.name,
      @required this.email,
      this.photoURL,
      this.photoLocal});

  //    CREATE TABLE user (
//        id          INTEGER PRIMARY KEY NOT NULL,
//        name        STRING  NOT NULL,
//        email       STRING  NOT NULL,
//        photo_url   STRING,
//        photo_local STRING
//    );

  User.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData["id"];
    this.name = mapData["name"];
    this.email = mapData["email"];
    this.photoURL = mapData["photo_url"];
    this.photoLocal = mapData["photo_local"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "photo_url": this.photoURL,
      "photo_local": this.photoLocal
    };
  }
}
