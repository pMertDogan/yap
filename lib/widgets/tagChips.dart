import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';

class TagChips extends StatefulWidget {
  @override
  _TagChipsState createState() => _TagChipsState();

  final ReactiveModel selectedRMModel;
  TagChips(this.selectedRMModel);
}

class _TagChipsState extends State<TagChips> {
  final Color grey = UIColors.grey;
  @override
  Widget build(BuildContext context) {
    final bool rmIsSubjectVM =
        widget.selectedRMModel is ReactiveModel<SubjectVM>;

    return StateBuilder(
      tag: "tags",
      observe: () => widget.selectedRMModel,
      builder: (context, subjectVMRM) {
        Set<String> tags = subjectVMRM.state.tags;
        return tags.isEmpty
            ? Container(
                child: rmIsSubjectVM
                    ? null
                    : Text(
                        "Please add a new tag",
                      ))
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
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onSelected: (bool selected) {
                            selected
                                ? subjectVMRM.setState(
                                    (s) => s.tagChipsSelect.add(index),
                                    filterTags: ["tags"])
                                : widget.selectedRMModel.setState(
                                    (s) => s.tagChipsSelect.removeWhere(
                                        (itemIndex) => itemIndex == index),
                                    filterTags: ["tags"]);
                          }),
                    );
                  },
                ),
              );
      },
    );
  }
}
