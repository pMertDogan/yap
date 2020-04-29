import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/addSubjectSheet/customSliderThumb.dart';

class PrioritySlider extends StatelessWidget {
  const PrioritySlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReactiveModel<SubjectVM> subjectVMRM =
        Injector.getAsReactive<SubjectVM>();

    return StateBuilder(
      models: [subjectVMRM],
      builder: (context, _) => SliderTheme(
        data: SliderThemeData(
          activeTrackColor: UIColors.todoOrange,
          inactiveTrackColor: Colors.red[100],
          //trackShape: RoundedRectSliderTrackShape(),
          trackHeight: 4.0,
          thumbShape: CustomSliderThumbCircle(thumbRadius: 20, min: 0, max: 10),
          thumbColor: Colors.redAccent,
          overlayColor: Colors.red.withAlpha(32),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
          //tickMarkShape: RoundSliderTickMarkShape(),
          activeTickMarkColor: UIColors.todoOrange,
          inactiveTickMarkColor: UIColors.grey,
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: Colors.redAccent,
          valueIndicatorTextStyle: TextStyle(
            color: UIColors.grey,
          ),
        ),
        child: Slider(
          min: 0,
          max: 10,
          divisions: 10,
          label: "Priority",
          value: subjectVMRM.state.priority.toDouble(),
          onChanged: (value) => subjectVMRM.setState(
            (state) => state.priority = value.toInt(),
          ),
        ),
      ),
    );
  }
}
