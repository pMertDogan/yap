import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';

class AddNewSubjectButton extends StatelessWidget {
  const AddNewSubjectButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StateBuilder<AddSubjectVM>(
        observe: () => RM.get<AddSubjectVM>(),
        builder: (context, addSubjectVMRM) => InkWell(
          onTap: () {
            addSubjectVMRM.setState((a) async {
              await a.addTagsToSubject();
              //Pop to show homeScreen
              RM.get<SubjectVM>().setState((s) =>
                  s.addSubject(a.subject).then((x) => Navigator.pop(context)));
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: UIColors.todoOrange,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: addSubjectVMRM.isWaiting
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "All is well",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
