import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
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
    return Container(
      height: 50,
      color: UIColors.darkBlue,
      child: TabBar(
        onTap: (index) {
          loginRMKey.state = index == 1 ? "I have a account" : "Login";
          singUpRMKey.state = index == 0 ? "Create a new account" : "SingUp";
          //Check is button clicked 2x
          if (lastTapIndex == index) {
            //Try sing in or sing up
            switch (index) {
              //Sing In
              case (0):
                print("Lets login user");
                RM.get<UserVM>().setState((s) async => s
                        .singIn(s.registerLoginEmail, s.registerLoginPassword)
                        .catchError((e) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }));
                break;
              //Sing Up
              case (1):
                //Update 2.0  not need add async for future
                RM.get<UserVM>().setState((s) => s.singUp(s.registerLoginEmail,
                    s.registerLoginPassword, s.registerLoginName));
                break;
            }
          }
          lastTapIndex = index;
        },
        indicatorColor: UIColors.grey,
        tabs: [
          Tab(
            child: WhenRebuilderOr<String>(
              rmKey: loginRMKey,
              observeMany: [
                () => RM.create<String>("Login"),
                () => RM.get<UserVM>()
              ],
              onWaiting: () => lastTapIndex == 0
                  ? OrangeLoadingIndicator()
                  : Text(
                      "Please wait...",
                      style: Theme.of(context).textTheme.headline4,
                    ),
              builder: (context, loginButtonTxt) {
                return Text(
                  loginButtonTxt.state,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ),
          Tab(
            child: WhenRebuilderOr<String>(
              rmKey: singUpRMKey,
              observeMany: [
                () => RM.create<String>("Create a new account"),
                () => RM.get<UserVM>()
              ],
              onWaiting: () => lastTapIndex == 1
                  ? OrangeLoadingIndicator()
                  : Text(
                      "Please wait...",
                      style: Theme.of(context).textTheme.headline4,
                    ),
              builder: (context, loginButtonTxt) {
                return Text(
                  loginButtonTxt.state,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
