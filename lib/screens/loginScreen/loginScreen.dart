import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/loginScreen/loginUI.dart';
import 'package:todo/screens/loginScreen/singUp.dart';
import 'package:todo/screens/loginScreen/tabBarUI.dart';
import 'package:todo/screens/loginScreen/topInfoUI.dart';
import 'package:todo/ui/colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBarUI(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(0),
            height: height - 49,
            width: width,
            color: UIColors.grey,
            child: Column(
              children: <Widget>[
                TopInfoArea(),
                BottomLoginSingUpUI(width: width)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomLoginSingUpUI extends StatelessWidget {
  const BottomLoginSingUpUI({
    Key key,
    @required this.width,
  }) : super(key: key);

  final Color grey = UIColors.grey;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            //   color: Colors.orange,
            ),
        child: TabBarView(
          children: [
            LoginUI(),
            SingUpUI(width: width),
          ],
        ),
      ),
    );
  }
}
