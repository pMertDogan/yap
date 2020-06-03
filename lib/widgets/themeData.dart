import 'package:flutter/material.dart';
import 'package:todo/utility/colors.dart';

const Color grey = UIColors.grey;
const Color blue = UIColors.darkBlue;
const Color sheetTextColor = UIColors.addSubjectSheetTextColor;

ThemeData buildThemeData() {
  return ThemeData(
      fontFamily: "DavidLibre",
      primaryColor: grey,
      hintColor: grey,
      cursorColor: grey,
      textTheme: TextTheme(
        //Test
        bodyText2: TextStyle(
          color: Colors.amber,
          fontSize: 18,
        ),
        // end
        headline4: TextStyle(
          color: grey,
          fontSize: 18,
        ),
        headline3: TextStyle(
          color: blue,
          fontSize: 18,
        ),
        headline2: TextStyle(
          color: sheetTextColor,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: grey, fontSize: 18),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: UIColors.todoOrange)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: UIColors.todoOrange)),
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
