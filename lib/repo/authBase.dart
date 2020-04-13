import 'package:todo/models/user.dart';

abstract class AuthBase {
  User singInWithEmailAndPass(String email, password);
  User singUpWithEmailAndPass(String email, password);
  bool passwordReset(String email) {}
}
