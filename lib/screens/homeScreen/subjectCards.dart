import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';

class ToDosCards extends StatelessWidget {
  const ToDosCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<SubjectVM>(
      observe: () => RM.get<SubjectVM>(),
      child: Container(
        child: Center(
            child: Text(
          "There is no to-dos",
          style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24),
        )),
      ),
      builderWithChild: (context, subjectVMRM, child) {
        List<Subject> subjectList = subjectVMRM.state.listOfSubjects;
        if (subjectList.isEmpty) {
          return child;
        } else {
          double screenHeightPercent = MediaQuery.of(context).size.height / 100;
          double screenWidthPercent = MediaQuery.of(context).size.width / 100;
          return AnimatedOpacity(
            opacity: subjectVMRM.isWaiting ? 0 : 1,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: Container(
              child: ListView.separated(
                  //add space between subjects
                  separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subjectList.length,
                  itemBuilder: (context, index) {
                    Subject subject = subjectList[index];

                    return Container(
                      height: screenHeightPercent * 15,
                      color: Colors.blueGrey,
                      child: Stack(
                        children: <Widget>[
                          BackgroundCardWithSubjectTitle(subject: subject),
                          CountDown(subject: subject),
                          Tags(
                              screenWidthPercent: screenWidthPercent,
                              screenHeightPercent: screenHeightPercent,
                              subject: subject),
                          ContributorsCircles(
                              screenHeightPercent: screenHeightPercent,
                              screenWidthPercent: screenWidthPercent,
                              subject: subject)
                        ],
                      ),
                    );
                    return OldUI(subjectList: subjectList, index: index);
                  }),
            ),
          );
        }
      },
    );
  }
}

class ContributorsCircles extends StatelessWidget {
  const ContributorsCircles({
    Key key,
    @required this.screenHeightPercent,
    @required this.screenWidthPercent,
    @required this.subject,
  }) : super(key: key);

  final double screenHeightPercent;
  final double screenWidthPercent;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: screenHeightPercent * 20 * 0.2,
      width: screenWidthPercent * 35,
      bottom: 0,
      right: screenWidthPercent * 5,
      child: Container(
        //color: Colors.red,
        alignment: Alignment.centerRight,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: subject.contributors.length,
          itemBuilder: (context, index) {
            return CircleAvatar(
              child: subject.contributors[index].photoLocal != null
                  ? Image.file(File(subject.contributors[index].photoLocal))
                  : FlutterLogo(),
            );
          },
        ),
      ),
    );
  }
}

class Tags extends StatelessWidget {
  const Tags({
    Key key,
    @required this.screenWidthPercent,
    @required this.screenHeightPercent,
    @required this.subject,
  }) : super(key: key);

  final double screenWidthPercent;
  final double screenHeightPercent;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: screenHeightPercent * 20 * 0.2,
      width: screenWidthPercent * 40,
      bottom: 0,
      left: screenWidthPercent * 12,
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: subject.tags.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Chip(
                      backgroundColor: UIColors.chipsColor,
                      label: Text(
                        subject.tags.elementAt(index),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                )),
      ),
    );
  }
}

class BackgroundCardWithSubjectTitle extends StatelessWidget {
  const BackgroundCardWithSubjectTitle({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.95,
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: UIColors.addSubjectSheetTextColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FlutterIcons.angle_up_faw5s,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      subject.priority.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(16.0)),
                    color: UIColors.addSubjectSheetLightColor),
                child: Text(
                  subject.title,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OldUI extends StatelessWidget {
  OldUI({
    Key key,
    @required this.subjectList,
    this.index,
  }) : super(key: key);
  int index;
  final List<Subject> subjectList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subjectList[index].title),
      subtitle: Text(
          //subjectList[index].contributors.toString()),
          subjectList[index].tags.toString() ?? "tags yok"),
      //subtitle: Text(subjectList[index].explanation ?? ""),
      leading: subjectList[index].picLocal != null
          ? CircleAvatar(
              backgroundImage: FileImage(File(subjectList[index].picLocal)),
            )
          : null,
    );
  }
}

class CountDown extends StatelessWidget {
  const CountDown({Key key, @required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return subject.endDate == null
        ? Container()
        : Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.20,
              child: Container(
                decoration: BoxDecoration(
                    color: UIColors.chipsColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //font awesome clock
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            FlutterIcons.clock_faw5s,
                            color: UIColors.addSubjectLighIconColor,
                          ),
                        ),
                      ),
                      Text(
                        subject.endDate + " " + subject.endTime,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
