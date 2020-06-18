import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
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
      builder: (context, xRM) {
        Set<String> tags = xRM.state.tags;
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
                  
                  //Enable reserve? if there is too many old tag user cant see newly added tag
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: FilterChip(
                        selected: xRM.state.tagChipsSelect.contains(index),
                        selectedColor: UIColors.chipsColor,
                        checkmarkColor: grey,
                        backgroundColor: Colors.grey,
                        label: Text(
                          tags.elementAt(index),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        onSelected: (selected) =>
                            onSelectedChips(selected, rmIsSubjectVM, index),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }

  void onSelectedChips(bool selected, rmIsSubjectVM, int tagIndex) {
    if (selected) {
      //check which rm is assinged to this
      if (rmIsSubjectVM) {
        RM.get<SubjectVM>().setState(
          (s) async {
            s.tagChipsSelect.add(tagIndex);
            await s.getSelectedDayData(filterByTags: true);
          },
        );
      }
      //AddSubjectVM
      else {
        RM.get<AddSubjectVM>().setState((s) => s.tagChipsSelect.add(tagIndex),
            filterTags: ["tags"]);
      }
    }
    //unselected
    else {
      if (rmIsSubjectVM) {
        RM.get<SubjectVM>().setState((s) async {
          s.tagChipsSelect.removeWhere((itemIndex) => itemIndex == tagIndex);
          return await s.getSelectedDayData(filterByTags: true);
        });
      }
      //AddSubjectVM
      else {
        RM.get<AddSubjectVM>().setState(
              (s) => s.tagChipsSelect
                  .removeWhere((itemIndex) => itemIndex == tagIndex),
            );
      }
    }
  }
}
