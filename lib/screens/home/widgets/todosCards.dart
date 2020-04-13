import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/subject.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/viewModels/subjectVM.dart';

class TodosCards extends StatelessWidget {
  const TodosCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SubjectVM subjectVM, child) {
        // To do: remove
        subjectVM.addNewSubject(Subject(
            title: "First 1",
            todoList: [ToDo(title: "a", comment: "f")],
            tags: ["sas"]));

        if (subjectVM.subjectList.isEmpty) {
          return Container(
            child: Center(
                child: Text(
              "There is no to-dos",
              style:
                  Theme.of(context).textTheme.display2.copyWith(fontSize: 24),
            )),
          );
        } else {
          return Column(
            children: <Widget>[
              for (Subject subject in subjectVM.subjectList)
                ListTile(
                  title: Text(subject.title.toString()),
                  subtitle: Text(subject.explanation.toString()),
                )
            ],
          );
        }
      },
    );
  }
}
