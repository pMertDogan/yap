import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

class AddTodoButon extends StatelessWidget {
  const AddTodoButon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: FractionallySizedBox(
      widthFactor: 0.5,
      child: FlatButton.icon(
          shape: StadiumBorder(),
          color: Colors.green,
          onPressed: () => showAddNewTodo(),
          icon: Icon(
            FlutterIcons.add_box_mdi,
            color: Colors.white,
          ),
          label: Text("Add new to do ",
              style: TextStyle(color: Colors.white, fontSize: 18))),
    ));
  }

  void showAddNewTodo() {
    final _key = GlobalKey<FormState>();
    String name, explanation;
    RM.scaffold.showBottomSheet(
        (context) => Form(
              key: _key,
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Add new todo",
                        style: TextStyle(color: Colors.yellow)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) =>
                          text.length <= 1 ? "Please input name" : null,
                      onSaved: (text) => name = text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          errorStyle:
                              TextStyle(color: Colors.orange, fontSize: 16),
                          labelText: "ToDo name",
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      child: TextFormField(
                        onSaved: (text) => explanation = text,
                        expands: true,
                        style: TextStyle(color: Colors.white),
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                            labelText: "ToDo explanation",
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  WhenRebuilderOr<DetailVM>(
                    observe: () => RM.get<DetailVM>(),
                    builder: (context, model) => FlatButton(
                      child: Text("Add",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          await model.setState((s) => s.addToDo(ToDo(
                                title: name,
                                explanation: explanation,
                                userID: RM.get<UserVM>().state.user.id,
                                changeInfo:
                                    "Added by ${RM.get<UserVM>().state.user.name} ",
                                changeDate: DateTime.now(),
                              )));
                          Navigator.pop(context);
                        }
                      },
                    ),
                    onWaiting: () => OrangeLoadingIndicator(),
                  )
                ],
              ),
            ),
        backgroundColor: UIColors.darkBlue);
  }
}
