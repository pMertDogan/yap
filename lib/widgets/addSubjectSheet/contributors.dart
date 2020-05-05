import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/models/friend.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/state/userVM.dart';

class ContributorsSelect extends StatelessWidget {
  const ContributorsSelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectVMRM = Injector.getAsReactive<SubjectVM>();
    final userRMVM = Injector.getAsReactive<UserVM>();

    return Container(
      height: 120,
      child: StateBuilder(
        models: [subjectVMRM, userRMVM],
        builder: (context, _) {
          List<Friend> friendsList = List.generate(
              5,
              (index) => Friend(
                  name: index.toString(),
                  id: index.toString(),
                  email: index.toString()));
          List<bool> _selected =
              List.generate(friendsList.length, (index) => true);

          return friendsList.length == 0
              ? Center(
                  child: Text("You dont have a friend"),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: friendsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          _selected[index] = !_selected[index];
                          return;
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://picsum.photos/id/${index + 10}/70/70"),
                              child: _selected[index]
                                  ? null
                                  : Container(
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
                                      ),
                                    ),
                            ),
//                            Padding(
//                              padding:
//                                  const EdgeInsets.symmetric(vertical: 8.0),
//                              child: Text(userRMVM.state.friends[index].name
//                                  .toString()),
//                            )
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
