import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    Key key,
    @required this.blue,
    @required this.grey,
  }) : super(key: key);

  final Color blue;
  final Color grey;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: blue,
      //notchMargin: 5,
      //shape: CircularNotchedRectangle(),
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
                    onPressed: () {},
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
