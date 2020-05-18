import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';
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
            RM.get<AddSubjectVM>(),
          ),
        )
      ],
    );
  }
}

class AddTagUI extends StatefulWidget {
  const AddTagUI({
    Key key,
  }) : super(key: key);

  @override
  _AddTagUIState createState() => _AddTagUIState();
}

class _AddTagUIState extends State<AddTagUI> {
  String yeniTag;

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
                        initialValue: yeniTag,
                        onChanged: (input) => yeniTag = input,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "add new tag",
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                  StateBuilder<AddSubjectVM>(
                    tag: "tags",
                    observe: () => RM.get<AddSubjectVM>(),
                    builder: (context, addRM) => FlatButton(
                        color: UIColors.addSubjectLighIconColor,
                        child: Text(
                          "Add tag",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        onPressed: () => addRM.setState((s) {
                              s.addTag(yeniTag);
                              print(yeniTag);
                            }, filterTags: ["tags"])),
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
