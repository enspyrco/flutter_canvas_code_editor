import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'state.dart';

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
);

class CodePainter extends CustomPainter {
  CodePainter() : super(repaint: codeChangeNotifier);
  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      children: codeChangeNotifier.tokens,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

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
