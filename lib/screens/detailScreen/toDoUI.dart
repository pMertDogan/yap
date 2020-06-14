import 'package:flutter/material.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/utility/colors.dart';

class ToDoUI extends StatelessWidget {
  const ToDoUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //ListTileTheme(iconColor: Colors,)
          //IconTheme(data: IconThemeData(color: Colors.red), child: null)
          ToDo todo = subject.toDoList[index];
          return Theme(
            data: Theme.of(context).copyWith(
              //listtile expanded icon
              accentColor: Colors.orange,
              //for listTile collapse icon
              unselectedWidgetColor: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? UIColors.purple
                      : UIColors.darkerPurple,
                  borderRadius:
                      BorderRadius.all(Radius.circular(8))),
              child: ExpansionTile(
                leading: Checkbox(
                    value: true,
                    onChanged: (a) {},
                    activeColor: Colors.black45),
                initiallyExpanded: index == 0,
                title: Text(
                  todo.title,
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  Text(todo.explanation ??
                      "There is no explanation")
                ],
                backgroundColor: index % 2 == 0
                    ? UIColors.purple
                    : UIColors.darkerPurple,
              ),
            ),
          );
        },
        childCount: subject.toDoList.length,
      ),
    );
  }
}
