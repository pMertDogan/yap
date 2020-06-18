import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/addSubjectSheet/addNewSubjectButton.dart';
import 'package:todo/widgets/addSubjectSheet/addPhoto.dart';
import 'package:todo/widgets/addSubjectSheet/contributors.dart';
import 'package:todo/widgets/addSubjectSheet/explanation.dart';
import 'package:todo/widgets/addSubjectSheet/location.dart';
import 'package:todo/widgets/addSubjectSheet/prioritySlider.dart';
import 'package:todo/widgets/addSubjectSheet/tagsAddOrSelect.dart';
import 'package:todo/widgets/addSubjectSheet/timeSelectUI.dart';
import 'package:todo/widgets/addSubjectSheet/titleFormField.dart';
import 'package:todo/widgets/addSubjectSheet/titleText.dart';
import 'package:todo/widgets/addSubjectSheet/yeniToDoUI.dart';
import 'package:todo/widgets/keyboardPadding.dart';

class AddSubjectSheet extends StatelessWidget {
  const AddSubjectSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //set bottom sheet height to %90
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Create a new Subject",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 26),
                  ),
                ),
                TitleText(
                  titleText: "Subject picture",
                ),
                AddPhoto(),
                TitleText(
                  titleText: "Subject title",
                ),
                TitleFormField(),
                TitleText(
                  titleText: "Subject explanation",
                ),
                ExplanationFromField(),
                Text(
                  "Timeline",
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                ),
                StartEndTimeLineUI(),
                TitleText(
                  titleText: "Where?",
                ),
                Location(),
                TitleText(
                  titleText: "Add contributor",
                ),
                ContributorsSelect(),
                TagsAddOrSelect(),
                TitleText(
                  titleText: "Priority",
                ),
                PrioritySlider(),
                AddNewToDoUI(),
                AddNewSubjectButton(),
              ],
            ), //Keyboard height as padding for let user see fields
            KeyboardPadding()
          ],
        ),
      ),
    );
  }
}
