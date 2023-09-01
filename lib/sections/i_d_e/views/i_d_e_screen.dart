import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percepts/percepts.dart';

import '../../editor/views/editor_view.dart';
import '../../workspace/views/workspace_view.dart';
import '../beliefs/i_d_e_beliefs.dart';
import '../../../build_context_extensions.dart';
import '../../workspace/models/directory_model.dart';
import '../../workspace/cognition/considerations/prompting_for_directory.dart';
import '../../../state.dart';

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
      body: const Row(
        children: [
          WorkspaceView(),
          EditorView(),
        ],
      ),
    );
  }
}
