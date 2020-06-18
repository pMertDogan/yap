import 'package:flutter/material.dart';

class KeyboardPadding extends StatelessWidget {
  const KeyboardPadding({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    );
  }
}