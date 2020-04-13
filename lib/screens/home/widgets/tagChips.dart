import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/viewModels/subjectVM.dart';

class TagChips extends StatefulWidget {
  const TagChips({
    Key key,
    @required this.chipsSelect,
    @required this.grey,
  }) : super(key: key);

  final List<int> chipsSelect;
  final Color grey;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SubjectVM subjectVM, child) {
        if (subjectVM.subjectList.isEmpty) {
          return Container();
        } else {
          return Container(
            height: 40,

            //Use wrap for expand area . Wrap()
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: FilterChip(
                    selected: widget.chipsSelect.contains(index),
                    selectedColor: UIColors.chipsColor,
                    checkmarkColor: widget.grey,
                    backgroundColor: Colors.grey,
                    label: Text(
                      "Tag $index",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    onSelected: (bool selected) {
                      setState(
                        () {
                          //Just removed when index value in list if already clicked
                          selected
                              ? widget.chipsSelect.add(index)
                              : widget.chipsSelect
                                  .removeWhere((item) => item == index);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
