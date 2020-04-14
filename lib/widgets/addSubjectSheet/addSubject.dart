import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/addSubjectSheet/timeSelectUI.dart';
import 'package:todo/widgets/addSubjectSheet/titleText.dart';

const Color grey = UIColors.grey;
const Color blue = UIColors.kapaliMavi;
const Color sheetBGColor = UIColors.addSubjectSheetBGColor;
const Color sheetLightColor = UIColors.addSubjectSheetLightColor;
const Color sheetYellowColor = UIColors.addSubjectSheetYellowColor;

class AddSubject extends StatelessWidget {
  const AddSubject({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //set bottom sheet heiht to %90
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Create a new Subject",
                style:
                    Theme.of(context).textTheme.display1.copyWith(fontSize: 26),
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
            //Keyboard height as padding for let user see fields
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.edit_location,
            size: 48,
            color: sheetLightColor,
          ),
          Text(
            "Add location",
            style: Theme.of(context).textTheme.display1,
          )
        ],
      ),
    );
  }
}

class AddPhoto extends StatelessWidget {
  const AddPhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      width: double.infinity,
      color: sheetLightColor,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_a_photo,
          color: sheetYellowColor,
          size: 32,
        ),
      ),
    );
  }
}

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          decoration: BoxDecoration(
              color: sheetLightColor, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(5),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "What should do?",
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: grey)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ));
  }
}

class ExplanationFromField extends StatelessWidget {
  const ExplanationFromField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sheetLightColor,
      padding: EdgeInsets.all(5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "  Everyone likes little secrets",
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: grey)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
