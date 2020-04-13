class User {
  String _userName;
  String _eMail;
  String _photoURL;

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
