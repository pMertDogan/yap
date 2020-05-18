import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/utility/validators.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({
    Key key,
  }) : super(key: key);

  final Color grey = UIColors.grey;

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserVM>(
      observeMany: [() => RM.get<UserVM>()],
      builder: (context, userVMRM) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          readOnly: userVMRM.isWaiting,
          initialValue: userVMRM.state.registerLoginEmail,
          autovalidate: true,
          validator: (input) {
            if (input.isValidEmail()) {
              userVMRM.state.registerLoginEmail = input;
              return null;
            } else {
              userVMRM.state.registerLoginEmail = null;
              return "Check your email";
            }
          },
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: UIColors.todoOrange, fontSize: 18),
            labelText: "Email",
            prefixIcon: Icon(
              Icons.email,
              color: grey,
            ),
          ),
        ),
      ),
    );
  }
}
