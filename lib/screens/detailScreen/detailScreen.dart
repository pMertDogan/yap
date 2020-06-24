import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/screens/detailScreen/addTodoButton.dart';
import 'package:todo/screens/detailScreen/contributorsUI.dart';
import 'package:todo/screens/detailScreen/explanationUI.dart';
import 'package:todo/screens/detailScreen/mapUI.dart';
import 'package:todo/screens/detailScreen/middleButtons.dart';
import 'package:todo/screens/detailScreen/sliverTopBar.dart';
import 'package:todo/screens/detailScreen/toDoUI.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/utility/colors.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: UIColors.grey,
        body: StateBuilder<DetailVM>(
            observe: () => RM.get<DetailVM>(),
            builder: (context, model) {
              Subject subject = model.state.subject;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverTopBar(subject),
                  ContributorsUI(subject: subject),
                  ExplanationUI(subject: subject),
                  MiddleButtons(),
                  MapUI(),
                  AddTodoButon(),
                  ToDoUI(),
                ],
              );
            }),
      ),
    );
  }
}
