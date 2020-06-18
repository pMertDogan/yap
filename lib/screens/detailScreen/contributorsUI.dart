import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

class ContributorsUI extends StatelessWidget {
  const ContributorsUI({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => addOrRemoveContributor(subject),
              child: CircleAvatar(
                radius: 25,
                child: Icon(
                  FlutterIcons.adduser_ant,
                  color: UIColors.grey,
                ),
                backgroundColor: UIColors.todoOrange,
              ),
            ),
            for (Friend contributor in subject.contributors)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 35,
                  child: contributor.photoLocal == null
                      ? Icon(
                          FlutterIcons.user_ant,
                          color: UIColors.grey,
                        )
                      : FileImage(File(contributor.photoLocal)),
                  backgroundColor: UIColors.darkBlue,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void addOrRemoveContributor(Subject subject) {
    final RMKey _rmKey = RMKey();
    RM.scaffold.showBottomSheet((context) {
      Set<Friend> friends = RM.get<UserVM>().state.user.friends;
      //List<Friend> contributors = <Friend>[]..addAll(subject.contributors);

      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StateBuilder<List<Friend>>(
                rmKey: _rmKey,
                observe: () => RM.create(<Friend>[...subject.contributors]),
                builder: (context, model) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 15,
                    runAlignment: WrapAlignment.center,
                    children: <Widget>[
                      for (Friend friend in friends)
                        InkWell(
                          onTap: () => model.state.contains(friend)
                              ? model.setState((s) => s.remove(friend))
                              : model.setState((s) => s.add(friend)),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: friend.photoLocal != null
                                    ? AssetImage(friend.photoLocal)
                                    : null,
                                child: model.state.contains(friend)
                                    ? Icon(FlutterIcons.check_ant)
                                    : Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(friend.userName),
                              )
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            StateBuilder<DetailVM>(
              observe: () => RM.get<DetailVM>(),
              builder: (context, model) => FlatButton(
                child: model.isWaiting
                    ? OrangeLoadingIndicator()
                    : Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () => RM.get<DetailVM>().setState(
                  (s) async {
                    await s.updateSubjectContributors(_rmKey.state);
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      );
    }, backgroundColor: UIColors.darkBlue);
  }
}
