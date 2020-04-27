import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/state/toDoVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/ui/themeData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color grey = UIColors.grey;
  final Color kapaliMavi = UIColors.kapaliMavi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yap',
      theme: buildThemeData(),
      //home: LoginScreen(),
      home: Injector(inject: [
        Inject<UserVM>(() => UserVM()),
        Inject<SubjectVM>(() => SubjectVM()),
        Inject<ToDoVM>(() => ToDoVM()),
      ], builder: (context) => Home()),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandinScreenState createState() => _LandinScreenState();
}

class _LandinScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("David Libre Font"),
      ),
    );
  }
}
