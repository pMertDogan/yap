import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';

class AddNewToDoUI extends StatelessWidget {
  const AddNewToDoUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Let's add new to do",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        TopBar(),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 125,
          color: UIColors.addSubjectSheetLightColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "  Everyone likes little secrets",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.navigate_before,
                    color: UIColors.grey,
                  ),
                  Text(
                    "Previus",
                    style: Theme.of(context).textTheme.display1,
                  )
                ],
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(
              "# 1",
              style: TextStyle(fontSize: 28),
            ))),
            FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Add new",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: UIColors.grey,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: UIColors.addSubjectSheetLightColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.info,
                color: UIColors.addSubjectLighIconColor,
              ),
              Text(
                "Title of the to do",
                style: Theme.of(context).textTheme.display1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
