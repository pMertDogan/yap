import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/subjectVM.dart';

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

        return subjectList.isEmpty
            ? child
            : Container(
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subjectList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(subjectList[index].title),
                        subtitle:
                            Text(subjectList[index].contributors.toString()),
                        //    subjectList[index].tags.toString() ?? "tags yok"),
                        //subtitle: Text(subjectList[index].explanation ?? ""),
                        leading: subjectList[index].picLocal != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(
                                    File(subjectList[index].picLocal)),
                              )
                            : null,
                      );
                    }),
              );
      },
    );
  }
}
