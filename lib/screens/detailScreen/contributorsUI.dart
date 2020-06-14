import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/utility/colors.dart';

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
            CircleAvatar(
              radius: 25,
              child: Icon(
                FlutterIcons.adduser_ant,
                color: UIColors.grey,
              ),
              backgroundColor: UIColors.todoOrange,
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
}