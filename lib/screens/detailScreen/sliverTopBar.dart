import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/screens/detailScreen/countDownAndTags.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

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
      actions: <Widget>[
        InkWell(
          onTap: () async {
            RM
                .get<DetailVM>()
                .setState((s) async => await s.updateFavoriteStatus());
          },
          child: TopBar(),
        )
      ],
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: TopTitleText(subject: subject),
        background: Stack(
          children: <Widget>[
            BackgroundImage(subject: subject),
            CountdownAndTagsRow(subject: subject),
          ],
        ),
      ),
    );
  }
}

class TopTitleText extends StatelessWidget {
  const TopTitleText({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: WhenRebuilderOr<DetailVM>(
        observe: () => RM.get<DetailVM>(),
        onWaiting: () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(child: OrangeLoadingIndicator()),
        ),
        watch: (model) => model.state.subject.favorite,
        builder: (context, model) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
              model.state.subject.favorite
                  ? FontAwesome.star
                  : FontAwesome.star_o,
              color: Colors.yellow),
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
    print("subject id " + subject.id.toString());
    return Hero(
      tag: subject.id.toString(),
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
