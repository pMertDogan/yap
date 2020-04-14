import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key key, @required this.titleText, this.padding = true})
      : super(key: key);

  final String titleText;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: padding
            ? EdgeInsets.only(left: 20, top: 10, bottom: 10)
            : EdgeInsets.only(),
        child: Text(
          titleText,
          style: Theme.of(context).textTheme.display3,
        ),
      ),
    );
  }
}
