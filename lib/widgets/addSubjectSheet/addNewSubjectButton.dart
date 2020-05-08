import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/models/friend.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/ui/colors.dart';

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
            addSubjectVMRM.setState((s) {
              //  s.addSubject(value)
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: UIColors.todoOrange,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "All is well",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  addSubjectVMRM.isWaiting
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
