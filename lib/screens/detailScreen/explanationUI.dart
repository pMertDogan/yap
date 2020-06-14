import 'package:flutter/material.dart';
import 'package:todo/data/models/subject.dart';

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
