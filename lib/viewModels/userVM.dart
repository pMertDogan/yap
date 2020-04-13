import 'package:flutter/material.dart';
import 'package:todo/models/user.dart';

enum Durum { init, notLogged, Singing, Singed }

class UserVM with ChangeNotifier {
  Durum _durum;
  User _user;


  Durum get durum => _durum;

  set durum(Durum value) {
    _durum = value;
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  UserVM() {
    durum = Durum.init;
  }

  User loginWithEmailAndPassword(String email, password) {}
  User singUpWithEmailAndPassword(String email, password) {}
  bool passwordReset(String email) {}
}
