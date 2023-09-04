import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../global_state.dart';
import '../../i_d_e/beliefs/i_d_e_beliefs.dart';

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
);

late TextPosition Function(Offset) getPositionForOffset;
TextSelection? selection;
var paint1 = Paint()
  ..color = const Color(0xff995588)
  ..style = PaintingStyle.fill;

class EditorPainter extends CustomPainter {
  EditorPainter() : super(repaint: codeUpdateNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    // final textSpan = TextSpan(
    //   children: codeChangeNotifier.tokens,
    //   style: textStyle,
    // );

    final textSpan = TextSpan(
      text: locate<BeliefSystem<IDEBeliefs>>()
          .beliefs
          .editor
          .characterMap
          ?.values
          .join(),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: size.width,
      maxWidth: size.width,
    );

    if (selection != null) {
      final textboxes = textPainter.getBoxesForSelection(selection!);
      TextBox textBox = textboxes.first;
      if (selection!.affinity == TextAffinity.upstream) {
        canvas.drawLine(
          Offset(textBox.right, textBox.top),
          Offset(textBox.right, textBox.bottom),
          paint1,
        );
      } else {
        canvas.drawLine(
          Offset(textBox.left, textBox.top),
          Offset(textBox.left, textBox.bottom),
          paint1,
        );
      }
    }

    getPositionForOffset = textPainter.getPositionForOffset;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      heightNotifier.value = textPainter.height;
    });

    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  @override
  // From docs: called when a new instance of the class is provided, to check if the new instance actually represents different information.
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
