import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/locator.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/viewModels/subjectVM.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color grey = UIColors.grey;
  final Color kapaliMavi = UIColors.kapaliMavi;
  final Color sheetTextColor = UIColors.addSubjectSheetTextColor;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt.get<SubjectVM>(),
        )
      ],
      child: MaterialApp(
        title: 'Yap',
        theme: buildThemeData(),
        //home: LoginScreen(),
        home: Home(),
      ),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
        fontFamily: "DavidLibre",
        primaryColor: grey,
        hintColor: grey,
        cursorColor: grey,
        textTheme: TextTheme(
          //Test
          body1: TextStyle(
            color: Colors.amber,
            fontSize: 18,
          ),
          // end
          display1: TextStyle(
            color: grey,
            fontSize: 18,
          ),
          display2: TextStyle(
            color: kapaliMavi,
            fontSize: 18,
          ),
          display3: TextStyle(
            color: sheetTextColor,
            fontSize: 18,
          ),
        ),
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
                borderSide: BorderSide(color: Colors.white))));
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
