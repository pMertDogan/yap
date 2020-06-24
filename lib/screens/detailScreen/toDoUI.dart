import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/data/models/user.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

class ToDoUI extends StatelessWidget {
  const ToDoUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<DetailVM>(
      observe: () => RM.get<DetailVM>(),
      builder: (context, model) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            ToDo todo = model.state.subject.toDoList[index];
            return Theme(
              data: Theme.of(context).copyWith(
                //listTile expanded icon
                accentColor: Colors.orange,
                //for listTile collapse icon
                unselectedWidgetColor: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? UIColors.purple
                        : UIColors.darkerPurple,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ExpansionTile(
                  leading: Checkbox(
                      value: todo.completed,
                      onChanged: (completed) {
                        RM
                            .get<DetailVM>()
                            .setState((s) => s.updateToDoStatus(index));
                      },
                      activeColor: Colors.black45),
                  initiallyExpanded: index == 0,
                  title: Text(
                    todo.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              todo.explanation ?? "There is no explanation"),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TodoUserPicture(todo),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(todo.changeInfo),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              FlutterIcons.clock_faw5s,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(Jiffy(todo.changeDate)
                                                .format("yyyy-MM-dd HH:mm:ss")),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: model.isWaiting
                                  ? OrangeLoadingIndicator()
                                  : InkWell(
                                      onTap: () => model.setState(
                                        (s) async {
                                          await s.removeTodoById(model.state
                                              .subject.toDoList[index].id);
                                        },
                                      ),
                                      child: Icon(
                                        FlutterIcons.trash_faw,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                  backgroundColor:
                      index % 2 == 0 ? UIColors.purple : UIColors.darkerPurple,
                ),
              ),
            );
          },
          childCount: model.state.subject.toDoList.length,
        ),
      ),
    );
  }
}

class TodoUserPicture extends StatelessWidget {
  const TodoUserPicture(
    this.todo, {
    Key key,
  }) : super(key: key);

  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    String picLocation;
    User user = RM.get<UserVM>().state.user;
    Set<Friend> contributors = user.friends;
    if (todo.userID == user.id) {
      picLocation = user.photoLocal;
    } else {
      contributors.forEach((Friend contributor) {
        if (contributor.id == todo.userID) {
          picLocation = contributor.photoLocal;
        }
      });
    }
    //if userID is not equal to current user or contributor
    //get photo using userID (if user not in contributors too.)
    if (picLocation == null) {
      //todo get avatar by userID
    }
    return CircleAvatar(
      radius: 30,
      child: picLocation != null
          ? Image.asset(picLocation)
          : Icon(FlutterIcons.user_ant),
    );
  }
}
