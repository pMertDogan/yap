import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';

class NameForm extends StatelessWidget {
  const NameForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserVM>(
      observeMany: [() => RM.get<UserVM>()],
      builder: (context, userVMRM) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          initialValue: userVMRM.state
              .registerLoginName, // TODO remove this , added for test login
          autovalidate: true,
          validator: (input) {
            bool test = input.length >= 3;
            if (test) {
              userVMRM.state.registerLoginName = input;
              return null;
            } else {
              userVMRM.state.registerLoginName = null;
              return "min 3 character";
            }
          },
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: UIColors.todoOrange, fontSize: 18),
            labelText: "Username",
            prefixIcon: Icon(
              Icons.perm_identity,
              color: UIColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
