import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'code_change_notifier.dart';

final codeChangeNotifier = CodeChangeNotifier();

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
);

bool keyEventHandler(KeyEvent event) {
  if (event.character != null) {
    if (event.logicalKey.keyLabel == 'Backspace') {
      codeChangeNotifier.remove();
    } else {
      codeChangeNotifier.add(event.character!);
    }
  }

  // indicates whether Flutter "handles" the event
  return true;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(keyEventHandler);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(keyEventHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(300, 300),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter() : super(repaint: codeChangeNotifier);
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
