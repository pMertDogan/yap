import 'package:flutter/material.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          decoration: BoxDecoration(
              color: sheetLightColor, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(5),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "What should do?",
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: grey)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ));
  }
}
