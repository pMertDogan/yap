import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';

const Color grey = UIColors.grey;
const Color blue = UIColors.kapaliMavi;
const Color sheetTextColor = UIColors.addSubjectSheetTextColor;

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
          color: blue,
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
