import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/pickImage.dart';
import 'formWidgets/emailForm.dart';
import 'formWidgets/passwordForm.dart';
import 'formWidgets/userNameForm.dart';

class SingUpUI extends StatelessWidget {
  const SingUpUI({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: UIColors.kapaliMavi,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Column(
                        children: <Widget>[
                          NameForm(),
                          EmailForm(),
                          PasswordForm(),
                          //Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
            left: (width / 2) - 50,
            child: StateBuilder<UserVM>(
              observe: () => RM.get<UserVM>(),
              builder: (context, userVMRM) => InkWell(
                onTap: () {
                  getImage(context).then((File selected) {
                    if (selected != null) {
                      print("selected image " + selected.toString());
                      userVMRM.setState((s) => s.registerAvatar = selected);
                    }
                  });
                },
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    //if user selected image
                    backgroundImage: userVMRM.state.registerAvatar != null
                        ? FileImage(
                            userVMRM.state.registerAvatar,
                          )
                        : null,

                    // if user not selected image
                    child: userVMRM.state.registerAvatar == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: UIColors.kapaliMavi,
                          )
                        : null),
              ),
            ))
      ],
    );
  }
}
