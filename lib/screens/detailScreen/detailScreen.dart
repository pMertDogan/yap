import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/screens/detailScreen/sliverTopBar.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/countDown.dart';

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
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                  
                      (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: index % 2 == 0
                              ? UIColors.purple
                              : UIColors.darkerPurple,
                          child: Text(subject.toDoList[index].title),
                        );
                      },
                      childCount: subject.toDoList.length,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class ExplanationUI extends StatelessWidget {
  const ExplanationUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: subject.explanation == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey)),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      subject.explanation,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ));
  }
}

class ContributorsUI extends StatelessWidget {
  const ContributorsUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              child: Icon(
                FlutterIcons.adduser_ant,
                color: UIColors.grey,
              ),
              backgroundColor: UIColors.todoOrange,
            ),
            for (Friend contributor in subject.contributors)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 35,
                  child: contributor.photoLocal == null
                      ? Icon(
                          FlutterIcons.user_ant,
                          color: UIColors.grey,
                        )
                      : FileImage(File(contributor.photoLocal)),
                  backgroundColor: UIColors.darkBlue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CountdownAndTags extends StatelessWidget {
  const CountdownAndTags({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 7,
      right: 30,
      height: 30,
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CountDown(
            subject: subject,
            heightPercent: 1,
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: subject.tags.length + 1,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: FilterChip(
                      backgroundColor: UIColors.chipsColor,
                      label: Text(
                        index == 0 ? "+" : subject.tags.elementAt(index - 1),
                        style: TextStyle(color: Colors.white),
                      ),
                      onSelected: (bool value) {},
                    ),
                  ))
        ],
      ),
    );
  }
}
