import 'package:flutter/material.dart';
import 'package:todo/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color grey = Color.fromRGBO(216, 216, 216, 1);
  final Color kapaliMavi = Color.fromRGBO(53, 73, 94, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yap',
      theme: ThemeData(
          fontFamily: "DavidLibre",
          primaryColor: grey,
          hintColor: grey,
          cursorColor: grey,
          textTheme: TextTheme(
              display1: TextStyle(
                color: grey,
                fontSize: 18,
              ),
              display2: TextStyle(
                color: kapaliMavi,
                fontSize: 18,
              )),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: grey, fontSize: 18),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.white)))),
      home: LoginScreen(),
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
