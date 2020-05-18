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
    id = mapData["id"];
    name = mapData["name"];
    email = mapData["email"];
    photoURL = mapData["photo_url"];
    photoLocal = mapData["photo_local"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo_url": photoURL,
      "photo_local": photoLocal
    };
  }
}
