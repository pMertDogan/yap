import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
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
                  MapUI(subject: subject),
                  ToDoUI(subject: subject),
                  AddButon(),
                ],
              );
            }),
      ),
    );
  }
}

class AddButon extends StatelessWidget {
  const AddButon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: FractionallySizedBox(
          widthFactor: 0.5,child: FlatButton.icon(
             shape: StadiumBorder(),
              color: Colors.green,
              onPressed: () {},
              icon: Icon(
                FlutterIcons.add_box_mdi,
                color: Colors.white,
              ),
              label: Text("Add new to do ",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18))),
        ));
  }
}
