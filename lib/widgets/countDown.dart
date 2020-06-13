import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/utility/colors.dart';

class CountDown extends StatelessWidget {
  const CountDown(
      {Key key, @required this.subject, @required this.heightPercent})
      : super(key: key);

  final Subject subject;
  final double heightPercent;
  @override
  Widget build(BuildContext context) {
    return subject.endDate == null
        ? Container()
        : Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: heightPercent,
              child: Container(
                decoration: BoxDecoration(
                    color: UIColors.chipsColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //font awesome clock
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Icon(
                          FlutterIcons.clock_faw5s,
                          color: UIColors.addSubjectLighIconColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        Jiffy(subject.endDate + "-" + subject.endTime,
                                "yyyy-MM-dd-HH:mm:ss")
                            .fromNow(),
                        //subject.endDate + " " + subject.endTime,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
