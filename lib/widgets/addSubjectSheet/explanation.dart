import 'package:flutter/material.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';

class ExplanationFromField extends StatelessWidget {
  const ExplanationFromField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sheetLightColor,
      padding: EdgeInsets.all(5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "  Everyone likes little secrets",
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: grey)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
