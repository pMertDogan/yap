import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: UIColors.grey,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Friends",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 38),
              ),
            ),
            AddFriendButton(),
            StateBuilder<UserVM>(
              observe: () => RM.get<UserVM>(),
              watch: (model) => model.state.user.friends,
              builderWithChild: (context, model, child) {
                Set<Friend> friends = model.state.user.friends;
                return friends.isEmpty
                    ? child
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: friends.length,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: UIColors.darkBlue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 27,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        friends
                                            .elementAt(index)
                                            .userName
                                            .toString(),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FlatButton.icon(
                                              onPressed: null,
                                              icon: Icon(
                                                  FlutterIcons.message1_ant,
                                                  color: Colors.green,
                                                  size: 20),
                                              label: Text(
                                                "Send messages",
                                                style: TextStyle(
                                                    color: UIColors.grey),
                                              )),
                                          //For avaoid overflow problems on smaller devices ?
                                          FlatButton.icon(
                                              onPressed: null,
                                              icon: Icon(
                                                FlutterIcons.cancel_mdi,
                                                size: 20,
                                                color: Colors.redAccent,
                                              ),
                                              label: Text(
                                                "Remove friend",
                                                style: TextStyle(
                                                    color: UIColors.grey),
                                              ))
                                        ],
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ),
                      );
              },
              child: Text("Thats bad, You dont have a any Friend :/"),
            )
          ],
        ),
      ),
    );
  }
}

class AddFriendButton extends StatelessWidget {
  const AddFriendButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: UIColors.darkBlue, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            FlutterIcons.add_circle_outline_mdi,
            color: Colors.white,
            size: 35,
          ),
          Text(
            "Add new Friend",
            style: TextStyle(color: UIColors.grey),
          ),
        ],
      ),
    );
  }
}
