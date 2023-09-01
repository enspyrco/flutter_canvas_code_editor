import 'package:flutter/material.dart';

import '../../../state.dart';
import 'editor_painter.dart';

class EditorView extends StatelessWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ValueListenableBuilder<double>(
            valueListenable: heightNotifier,
            builder: (context, value, child) {
              return LayoutBuilder(builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, heightNotifier.value),
                  painter: EditorPainter(),
                );
              });
            }),
      ),
    );
    ;
  }
}
