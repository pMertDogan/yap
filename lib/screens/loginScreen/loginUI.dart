import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';

import 'formWidgets/emailForm.dart';
import 'formWidgets/passwordForm.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({
    Key key,
  }) : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final Color kapaliMavi = UIColors.darkBlue;
  final Color grey = UIColors.grey;
  final userVMRM = RM.get<UserVM>();

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kapaliMavi,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Welcome",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 25),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: <Widget>[
                      EmailForm(),
                      PasswordForm(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          child: Text(
                            "lost password?",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
