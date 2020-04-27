import 'package:flutter/material.dart';

class Friend {
  String _name;
  String _email;
  String _id;
  String _pictureLocal;
  String _pictureURL;

  Friend(
      {@required name,
      @required email,
      @required id,
      pictureLocal,
      pictureURL});

  get pictureURL => _pictureURL;

  set pictureURL(value) {
    _pictureURL = value;
  }

  get pictureLocal => _pictureLocal;

  set pictureLocal(value) {
    _pictureLocal = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
