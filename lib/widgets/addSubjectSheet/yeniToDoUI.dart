import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';

//Dirty code start :)

class AddNewToDoUI extends StatelessWidget {
  const AddNewToDoUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AddSubjectVM>(
      tag: "ToDo",
      observe: () => RM.get<AddSubjectVM>(),
      builder: (context, addSubjectVMRM) {
        List<ToDo> _toDoList = addSubjectVMRM.state.subject.toDoList;
        int toDoIndex = addSubjectVMRM.state.toDoIndex;

        //Set title text to old value
        TextEditingController _controllerTitle = TextEditingController()
          ..text = _toDoList[toDoIndex].title
          ..selection = TextSelection.fromPosition(
              TextPosition(offset: _toDoList[toDoIndex].title.length));
        //Set explanation text to old value
        TextEditingController _controllerExplanation = TextEditingController()
          ..text = _toDoList[toDoIndex].explanation
          ..selection = TextSelection.fromPosition(
              TextPosition(offset: _toDoList[toDoIndex].explanation.length));

        RMKey<String> rmKeyTitle = RMKey<String>("");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Let's add new to do",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: UIColors.addSubjectSheetLightColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.info,
                        color: UIColors.addSubjectLighIconColor,
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: TextFormField(
                        controller: _controllerTitle,
                        onChanged: (input) {
                          print(input);
                          rmKeyTitle.state = input;
                          return addSubjectVMRM
                              .state.subject.toDoList[toDoIndex].title = input;
                        },
                        autovalidate: true,
                        validator: (input) =>
                            input.length >= 3 ? null : "Please input title",
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorStyle:
                              TextStyle(color: Colors.amber, fontSize: 18),
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintStyle: Theme.of(context).textTheme.headline4,
                          hintText: "Title of the to do",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 125,
              color: UIColors.addSubjectSheetLightColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerExplanation,
                  onChanged: (input) => addSubjectVMRM
                      .state.subject.toDoList[toDoIndex].explanation = input,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "  Everyone likes little secrets",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    if (toDoIndex > 0) {
                      rmKeyTitle.state = _toDoList[toDoIndex - 1].explanation;
                      addSubjectVMRM.setState((s) => s.toDoIndex = --toDoIndex,
                          filterTags: ["ToDo"]);
                    }
                  },
                  child: toDoIndex > 0
                      ? Row(
                          children: <Widget>[
                            Icon(
                              Icons.navigate_before,
                              color: UIColors.grey,
                            ),
                            Text(
                              "Previous",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        )
                      : null,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "# " + (addSubjectVMRM.state.toDoIndex + 1).toString(),
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                StateBuilder<String>(
                  observe: () =>
                      RM.create<String>(_toDoList[toDoIndex].explanation),
                  rmKey: rmKeyTitle,
                  builder: (context, titleString) => FlatButton(
                    onPressed: titleString.state.length > 3
                        ? () => addSubjectVMRM.setState((s) {
                              s.subject.toDoList.add(ToDo());
                              rmKeyTitle.state =
                                  _toDoList[toDoIndex + 1].explanation;
                              s.toDoIndex = ++toDoIndex;
                            }, filterTags: ["ToDo"])
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Add new",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: UIColors.grey,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
