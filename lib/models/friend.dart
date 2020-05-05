import 'package:flutter/material.dart';

class Friend {
  String _name;
  String _email;
  String _id;
  String _pictureLocal;
  String _pictureURL;

  // Kurucu _name ile hallet hata var böyle yaparsan
  Friend(
      {@required name,
      @required email,
      @required id,
      pictureLocal,
      pictureURL});

  String get pictureURL => _pictureURL;

  set pictureURL(String value) {
    _pictureURL = value;
  }

  String get pictureLocal => _pictureLocal;

  set pictureLocal(String value) {
    _pictureLocal = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
