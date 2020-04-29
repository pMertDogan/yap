import 'package:todo/models/friend.dart';
import 'package:todo/models/user.dart';

class UserVM {
  String test = "test value";
  User _user = User(userName: "deneme");
  List<Friend> _friends = <Friend>[
    Friend(id: 0, name: "Fatih", email: "1fatih@gmail.co"),
    Friend(id: 1, name: "Mert", email: "deneme@dd.co")
  ];
  

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  List<Friend> get friends => _friends;

  set friends(List<Friend> value) {
    _friends = value;
  }
}
