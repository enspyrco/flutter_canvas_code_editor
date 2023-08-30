import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percepts/percepts.dart';

import 'beliefs/i_d_e_beliefs.dart';
import '../../build_context_extensions.dart';
import '../../code_painter.dart';
import '../workspace/models/directory_model.dart';
import '../workspace/cognition/considerations/prompting_for_directory.dart';
import '../../state.dart';

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

class IDEScreen extends StatefulWidget {
  const IDEScreen({super.key});

  @override
  State<IDEScreen> createState() => _IDEScreenState();
}

class _IDEScreenState extends State<IDEScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Mini IDE'),
        actions: [
          TextButton(
            onPressed: () async {
              context.consider(const PromptingForDirectory());
            },
            child: const Text('Open'),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
              width: 200,
              child: StreamOfConsciousness<IDEBeliefs, DirectoryModel>(
                infer: (beliefs) =>
                    DirectoryModel(beliefs.workspace.entityNames),
                builder: (context, model) {
                  return ListView(children: [
                    ...model.fileSystemEntityNames.map<Widget>(
                      (element) => ListTile(
                        leading: const Icon(
                          Icons.file_copy,
                          size: 20,
                        ),
                        title: Text(element.basename),
                        onTap: () async {
                          // context.consider(element.dirname)
                          codeChangeNotifier.remove();
                          File file =
                              File('${element.dirname}/${element.basename}');
                          codeChangeNotifier.add(file.readAsStringSync());
                        },
                      ),
                    )
                  ]);
                },
              )),
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder<double>(
                  valueListenable: heightNotifier,
                  builder: (context, value, child) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, heightNotifier.value),
                        painter: CodePainter(),
                      );
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
