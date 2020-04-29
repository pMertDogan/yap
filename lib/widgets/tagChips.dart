import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/toDoVM.dart';
import 'package:todo/ui/colors.dart';

class TagChips extends StatefulWidget {
  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {
  final ReactiveModel<ToDoVM> toDoVMRM = Injector.getAsReactive<ToDoVM>();
  final Color grey = UIColors.grey;
  List<int> chipsSelect;

  @override
  void initState() {
    // TODO: implement initState
    chipsSelect =
        List.generate(toDoVMRM.state.toDoList.length, (index) => index + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: FilterChip(
              selected: chipsSelect.contains(index),
              selectedColor: UIColors.chipsColor,
              checkmarkColor: grey,
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
                        ? chipsSelect.add(index)
                        : chipsSelect.removeWhere((item) => item == index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
