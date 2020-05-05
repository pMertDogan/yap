import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/models/friend.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/ui/colors.dart';

class AddNewSubjectButton extends StatelessWidget {
  const AddNewSubjectButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserVM> userVMRM = Injector.getAsReactive<UserVM>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print("added new test Friend to USERVM");
//          userVMRM.setState((state) => state.friends
//              .add(Friend(id: 2, name: "deee", email: "asd@gmail.co")));
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
                Icon(
                  Icons.check,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
