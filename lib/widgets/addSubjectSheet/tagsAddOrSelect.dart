import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/addSubjectSheet/titleText.dart';
import 'package:todo/widgets/tagChips.dart';

class TagsAddOrSelect extends StatelessWidget {
  const TagsAddOrSelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AddTagUI(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: TagChips(
            sheetMode: true,
          ),
        )
      ],
    );
  }
}

class AddTagUI extends StatelessWidget {
  const AddTagUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String yeniTag;

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
                          onChanged: (input) => yeniTag = input,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "add new tag",
                              focusedBorder: InputBorder.none,
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
                      onPressed: () => RM.getSetState<AddSubjectVM>(
                          (s) => s.addTag(yeniTag),
                          filterTags: ["tags"])),
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
