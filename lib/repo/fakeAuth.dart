import 'package:todo/models/user.dart';
import 'package:todo/repo/authBase.dart';

class FakeAuth implements AuthBase {
  @override
  bool passwordReset(String email) {
    // TODO: implement passwordReset
    return null;
  }

  @override
  User singInWithEmailAndPass(String email, password) {
    // TODO: implement singInWithEmailAndPass
    return null;
  }

  @override
  User singUpWithEmailAndPass(String email, password) {
    // TODO: implement singUpWithEmailAndPass
    return null;
  }
}
