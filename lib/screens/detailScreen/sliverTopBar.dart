import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/screens/detailScreen/detailScreen.dart';
import 'package:todo/utility/colors.dart';

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
    this.subject, {
    Key key,
  }) : super(key: key);
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      //actionsIconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FlutterIcons.star_faw, color: Colors.yellow),
            ),
          ),
        )
      ],
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(subject.title ?? "",
                    //maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        background: Stack(
          children: <Widget>[
            BackgroundImage(subject: subject),
            CountdownAndTags(subject: subject),
          ],
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: subject.id,
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: UIColors.purple,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            image: subject.picLocal != null
                ? DecorationImage(
                    image: FileImage(File(subject.picLocal)), fit: BoxFit.cover)
                : null),
      ),
    );
  }
}
