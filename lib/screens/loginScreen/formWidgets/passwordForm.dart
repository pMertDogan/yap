import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserVM>(
      observe: () => RM.get<UserVM>(),
      builder: (context, userVMRM) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          readOnly: userVMRM.isWaiting,
          autovalidate: true,
          initialValue: userVMRM.state.registerLoginPassword,
          validator: (input) {
            if (input.length >= 6) {
              userVMRM.state.registerLoginPassword = input;
              return null;
            } else {
              userVMRM.state.registerLoginPassword = null;
              return "Too weak";
            }
          },
          obscureText: true,
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: UIColors.todoOrange, fontSize: 18),
            labelText: "Password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: UIColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
