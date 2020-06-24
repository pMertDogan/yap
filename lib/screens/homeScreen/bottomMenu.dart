import 'package:flutter/material.dart';
import 'package:todo/screens/friendsScreen/friendsScreen.dart';
import 'package:todo/utility/colors.dart';

class BottomMenuUI extends StatelessWidget {
  const BottomMenuUI({
    Key key,
  }) : super(key: key);

  final Color blue = UIColors.darkBlue;
  final Color grey = UIColors.grey;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: blue,
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: grey,
                    ),
                    label: Text(
                      "Message",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 21),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: FlatButton.icon(
                    onPressed: () {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendsScreen(),
                          ));
                    },
                    icon: Icon(
                      Icons.supervisor_account,
                      color: grey,
                    ),
                    label: Text(
                      "Friends",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 21),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
