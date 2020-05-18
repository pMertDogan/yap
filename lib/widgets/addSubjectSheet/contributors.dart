import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/userVM.dart';

class ContributorsSelect extends StatelessWidget {
  const ContributorsSelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addSubjectVMRM = RM.get<AddSubjectVM>();

    return Container(
      height: 120,
      child: StateBuilder<UserVM>(
        tag: ["contributors"], //Test
        observeMany: [() => RM.get<UserVM>(), () => addSubjectVMRM],
        //I dont want rebuild this
        child: Center(
          child: Text(
            "You dont have a friend",
          ),
        ),
        builderWithChild: (context, userVMRM, child) {
          //Friend List
          Set<Friend> friendsList = userVMRM.state.user.friends;
          //list for check state of the friends (selected..)
          List<bool> _selected = addSubjectVMRM.state.selectedFriendList;

          return friendsList.length == 0
              ? child //Rebuild optimization
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      friendsList.length, //For each friend create a Widget
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () => addSubjectVMRM.setState(
                            (s) => s.changeContributorStatus(index),
                            filterTags: ["contributors"]),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://picsum.photos/id/${index + 2}/70/70"),
                              child: _selected[index]
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(220, 214, 247, 55),
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                      width: 70,
                                      height: 70,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 36,
                                      ),
                                    )
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                friendsList.elementAt(index).userName,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
