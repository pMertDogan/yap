import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/ui/colors.dart';

class TagChips extends StatefulWidget {
  @override
  _TagChipsState createState() => _TagChipsState();

  const TagChips({this.sheetMode = false});

  final bool sheetMode;
}

class _TagChipsState extends State<TagChips> {
  final Color grey = UIColors.grey;

  @override
  Widget build(BuildContext context) {
    ReactiveModel selectedRMModel =
        widget.sheetMode ? RM.get<AddSubjectVM>() : RM.get<SubjectVM>();
    return StateBuilder(
      tag: "tags",
      observe: () => selectedRMModel,
      builder: (context, subjectVMRM) {
        Set<String> tags = subjectVMRM.state.tags;
        return tags.isEmpty
            ? Container(
                child: widget.sheetMode
                    ? Text(
                        "Please add a new tag",
                      )
                    : null)
            : Container(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: FilterChip(
                        selected:
                            subjectVMRM.state.tagChipsSelect.contains(index),
                        selectedColor: UIColors.chipsColor,
                        checkmarkColor: grey,
                        backgroundColor: Colors.grey,
                        label: Text(
                          tags.elementAt(index),
                          style: Theme.of(context).textTheme.display1,
                        ),
                        onSelected: (bool selected) {
                          selected
                              ? subjectVMRM.setState(
                                  (s) => s.tagChipsSelect.add(index),
                                  filterTags: ["tags"])
                              : subjectVMRM.setState(
                                  (s) => s.tagChipsSelect.removeWhere(
                                      (itemIndex) => itemIndex == index),
                                  filterTags: ["tags"]);
                        },
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
