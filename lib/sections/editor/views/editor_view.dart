import 'package:flutter/material.dart';

import '../../../utils/global_state.dart';
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
                return GestureDetector(
                  child: CustomPaint(
                    size: Size(constraints.maxWidth, heightNotifier.value),
                    painter: EditorPainter(),
                  ),
                  onTapUp: (details) {
                    TextPosition position =
                        getPositionForOffset(details.localPosition);
                    selection = TextSelection(
                      baseOffset: position.offset,
                      extentOffset: (position.affinity == TextAffinity.upstream)
                          ? position.offset - 1
                          : position.offset + 1,
                      affinity: position.affinity,
                    );
                    codeUpdateNotifier.update();
                  },
                );
              });
            }),
      ),
    );
  }
}
