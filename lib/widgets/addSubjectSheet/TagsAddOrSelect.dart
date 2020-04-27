import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/addSubjectSheet/titleText.dart';
import 'package:todo/widgets/homeScreen/tagChips.dart';

class TagsAddOrSelect extends StatelessWidget {
  const TagsAddOrSelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[AddTagUI(), TagChips()],
    );
  }
}

class AddTagUI extends StatelessWidget {
  const AddTagUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TitleText(
          titleText: "Tags",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 4),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: UIColors.addSubjectLighIconColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("  #  "),
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "add new tag",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide()),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        )),
                  ),
                  FlatButton(
                    color: UIColors.addSubjectLighIconColor,
                    child: Text(
                      "Add tag",
                      style: Theme.of(context).textTheme.display2,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
