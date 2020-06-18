import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/screens/detailScreen/detailScreen.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/countDown.dart';

class SubjectCards extends StatelessWidget {
  const SubjectCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<SubjectVM>(
      observe: () => RM.get<SubjectVM>(),
      child: ThereIsNoTodosText(),
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
            child: ListView.separated(
                //add space between subjects
                separatorBuilder: (context, index) =>
                    Padding(padding: EdgeInsets.all(3)),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: subjectList.length,
                itemBuilder: (context, index) {
                  Subject subject = subjectList[index];

                  return InkWell(
                    onTap: () => onTapOpenDetailsPage(subject, context),
                    child: Container(
                      height: screenHeightPercent * 15,
                      //color: UIColors.darkBlue,
                      child: Stack(
                        children: <Widget>[
                          CardContainer(subject: subject, index: index),
                          CountDown(
                            subject: subject,
                            heightPercent: 0.20,
                          ),
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
                    ),
                  );
                }),
          );
        }
      },
    );
  }

  void onTapOpenDetailsPage(Subject subject, BuildContext context) {
    //pass subject to VM with silent parameter because
    //statebuilder is inside DetailScreen and its not initialized
    RM.get<DetailVM>().setState((s) => s.subject = subject, silent: true);
    //open details screen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailScreen()));
  }
}

class ThereIsNoTodosText extends StatelessWidget {
  const ThereIsNoTodosText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "There is no to-dos",
        style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24),
      )),
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
              child: subject.contributors[index].photoURL != null
                  ? Image.file(File(subject.contributors[index].photoURL))
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

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key key,
    @required this.subject,
    @required this.index,
  }) : super(key: key);

  final Subject subject;
  final int index;

  @override
  Widget build(BuildContext context) {
    double completePercentOfSubject = 0;
    //calc percent
    subject.toDoList.forEach((element) {
      if (element.completed) {
        completePercentOfSubject += (1 / subject.toDoList.length);
      }
    });
    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.95,
        child: Row(
          children: <Widget>[
            PriorityLegend(subject: subject),
            Expanded(
              //Background Card
              child: Hero(
                tag: subject.id.toString(),
                //add material to avoid hero error
                child: Material(
                  //to fix background color
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.darken,
                      image: subject.picLocal == null
                          ? null
                          : DecorationImage(
                              image: FileImage(File(subject.picLocal)),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
                            ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(16.0)),
                      color: index % 2 == 0
                          ? UIColors.purple
                          : UIColors.darkerPurple,
                    ),
                    child: Row(
                      children: <Widget>[
                        //Card middle with Text
                        PercentUI(
                            completePercentOfSubject: completePercentOfSubject),
                        //Subject Title
                        CenterTitleUI(subject: subject),
                        //Favorite icon
                        FavoriteUI(subject: subject)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteUI extends StatelessWidget {
  const FavoriteUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0)),
            color: Colors.black54),
        child: InkWell(
          onTap: () async => RM
              .get<SubjectVM>()
              .setState((s) async => await s.updateFavoriteStatus(subject)),
          child: Icon(
            subject.favorite ? FontAwesome.star : FontAwesome.star_o,
            size: 18,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}

class CenterTitleUI extends StatelessWidget {
  const CenterTitleUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(subject.title,
            style: TextStyle(color: Colors.white, fontSize: 28),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ),
    );
  }
}

class PercentUI extends StatelessWidget {
  const PercentUI({
    Key key,
    @required this.completePercentOfSubject,
  }) : super(key: key);

  final double completePercentOfSubject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularPercentIndicator(
        radius: 45.0,
        lineWidth: 2.0,
        percent: completePercentOfSubject,
        center: Text(
            ((completePercentOfSubject * 100).truncate()).toString() + "%"),
        progressColor: Colors.green,
      ),
    );
  }
}

class PriorityLegend extends StatelessWidget {
  const PriorityLegend({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: UIColors.addSubjectSheetTextColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
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
    );
  }
}
