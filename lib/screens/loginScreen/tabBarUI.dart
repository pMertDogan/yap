import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

class TabBarUI extends StatefulWidget {
  const TabBarUI({
    Key key,
  }) : super(key: key);

  @override
  _TabBarUIState createState() => _TabBarUIState();
}

class _TabBarUIState extends State<TabBarUI> {
  int lastTapIndex = 0;
  final RMKey loginRMKey = RMKey<String>("Login");
  final RMKey singUpRMKey = RMKey<String>("SingUp button RM Key");

  @override
  Widget build(BuildContext context) {
    final userVMRM2 = RM.get<UserVM>();

    return Container(
      height: 50,
      color: UIColors.kapaliMavi,
      child: TabBar(
        onTap: (index) {
          loginRMKey.value = index == 1 ? "I have a account" : "Login";
          singUpRMKey.value = index == 0 ? "Create a new account" : "SingUp";

          //Check is button clicked 2x
          if (lastTapIndex == index) {
            //Try sing in or sing up

            switch (index) {
              //Sing In
              case (0):
                print("Lets login user");
                userVMRM2.setState((s) async => s
                        .singInWithEmailAndPass(
                            s.registerLoginEmail, s.registerLoginPassword)
                        .catchError((e) {
                      print("login error " + e.toString());
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }));
                break;
              //Sing Up
              case (1):
                userVMRM2.setState((s) async => s.singUpWithEmailAndPass(
                    s.registerLoginEmail,
                    s.registerLoginPassword,
                    s.registerLoginName));
                break;
            }
          }
          lastTapIndex = index;
        },
        indicatorColor: UIColors.grey,
        tabs: [
          WhenRebuilderOr<String>(
            rmKey: loginRMKey,
            observeMany: [() => RM.create<String>("Login"), () => userVMRM2],
            onWaiting: () => lastTapIndex == 0
                ? OrangeLoadingIndicator()
                : Text(
                    "Please wait...",
                    style: Theme.of(context).textTheme.display1,
                  ),
            builder: (context, loginButtonTxt) {
              return Tab(
                child: Text(
                  loginButtonTxt.value,
                  style: Theme.of(context).textTheme.display1,
                ),
              );
            },
          ),
          WhenRebuilderOr<String>(
            rmKey: singUpRMKey,
            observeMany: [
              () => RM.create<String>("Create a new account"),
              () => userVMRM2
            ],
            onWaiting: () => lastTapIndex == 1
                ? OrangeLoadingIndicator()
                : Text(
                    "Please wait...",
                    style: Theme.of(context).textTheme.display1,
                  ),
            builder: (context, loginButtonTxt) {
              return Tab(
                child: Text(
                  loginButtonTxt.value,
                  style: Theme.of(context).textTheme.display1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
