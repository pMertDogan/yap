import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';

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
            color: UIColors.addSubjectSheetLightColor,
            borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(5),
        child: StateBuilder<AddSubjectVM>(
          observe: () => RM.get<AddSubjectVM>(),
          builder: (context, addSubjectVMRM) => TextFormField(
            autovalidate: true,
            validator: (input) {
              //addSubjectVMRM.state.subjectTitle = input;
              addSubjectVMRM.state.subject.title = input;
              return input.length <= 2 ? "Please input more" : null;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "What should do?",
                errorStyle: TextStyle(color: Colors.amber, fontSize: 18),
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
