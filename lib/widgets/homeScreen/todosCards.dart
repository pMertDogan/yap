import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodosCards extends StatelessWidget {
  const TodosCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "There is no to-dos",
        style: Theme.of(context).textTheme.display2.copyWith(fontSize: 24),
      )),
    );
  }
}
