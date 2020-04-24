import 'package:todo/models/friend.dart';

class User {
  String _userName;
  String _eMail;
  String _photoURL;
  List<Friend> _friends = <Friend>[];

  List<Friend> get friends => _friends;

  set friends(List<Friend> value) {
    _friends = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get eMail => _eMail;

  String get photoURL => _photoURL;

  set photoURL(String value) {
    _photoURL = value;
  }

  set eMail(String value) {
    _eMail = value;
  }

  User({userName, eMail, photoURL});
}
