import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';

class ExplanationFromField extends StatelessWidget {
  const ExplanationFromField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIColors.addSubjectSheetLightColor,
      padding: EdgeInsets.all(5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "  Everyone likes little secrets",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: UIColors.grey)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
