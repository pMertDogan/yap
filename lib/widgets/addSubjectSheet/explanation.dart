import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';

class ExplanationFromField extends StatelessWidget {
  const ExplanationFromField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: UIColors.purple,
        padding: EdgeInsets.all(5),
        child: TextFormField(
          onChanged: (input) =>
              RM.get<AddSubjectVM>().state.subject.explanation = input,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "  Everyone likes little secrets",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: UIColors.grey)),
              border: InputBorder.none,
              enabledBorder: InputBorder.none),
        ));
  }
}
