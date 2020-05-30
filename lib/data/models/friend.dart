import 'package:flutter/material.dart';

class Friend {
  int id;
  String userName;
  String email;
  String photoURL;
  String photoLocal;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Friend({
    @required this.id,
    @required this.userName,
    @required this.email,
    this.photoURL,
    this.photoLocal,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userName == other.userName &&
          email == other.email &&
          photoURL == other.photoURL &&
          photoLocal == other.photoLocal);

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      photoURL.hashCode ^
      photoLocal.hashCode;

  @override
  String toString() {
    return 'Friend{' +
        ' id: $id,' +
        ' userName: $userName,' +
        ' email: $email,' +
        ' photoURL: $photoURL,' +
        ' photoLocal: $photoLocal,' +
        '}';
  }

  Friend copyWith({
    String id,
    String userName,
    String email,
    String photoURL,
    String photoLocal,
  }) {
    return new Friend(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      photoLocal: photoLocal ?? this.photoLocal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.userName,
      'email': this.email,
      'photo_url': this.photoURL,
      'photo_local': this.photoLocal,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return new Friend(
      id: map['id'] as int,
      userName: map['name'] as String,
      email: map['email'] as String,
      photoURL: map['photo_url'] as String,
      photoLocal: map['photo_local'] as String,
    );
  }

//</editor-fold>
}
