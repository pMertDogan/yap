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
  Set<Friend> friends;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    this.photoURL,
    this.photoLocal,
    friends,
  }) : this.friends = friends ?? <Friend>{};

//   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          photoURL == other.photoURL &&
          photoLocal == other.photoLocal &&
          friends == other.friends);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoURL.hashCode ^
      photoLocal.hashCode ^
      friends.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' photoURL: $photoURL,' +
        ' photoLocal: $photoLocal,' +
        ' friends: $friends,' +
        '}';
  }

  User copyWith({
    int id,
    String name,
    String email,
    String photoURL,
    String photoLocal,
    Set<Friend> friends,
  }) {
    return new User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      photoLocal: photoLocal ?? this.photoLocal,
      friends: friends ?? this.friends,
    );
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData["id"];
    this.name = mapData["name"];
    this.email = mapData["email"];
    this.photoURL = mapData["photo_url"];
    this.photoLocal = mapData["photo_local"];
    // dont forget friends!
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

  //</editor-fold>
// CREATE TABLE user (
//        id          INTEGER PRIMARY KEY NOT NULL,
//        name        STRING  NOT NULL,
//        email       STRING  NOT NULL,
//        photo_url   STRING,
//        photo_local STRING
//    );

}
