import 'package:flutter/material.dart';
import 'package:todo/utility/colors.dart';

class OrangeLoadingIndicator extends StatelessWidget {
  const OrangeLoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        backgroundColor: UIColors.todoOrange,
        valueColor: new AlwaysStoppedAnimation<Color>(UIColors.kapaliMavi));
  }
}
