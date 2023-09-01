import 'package:flutter/material.dart';
import 'package:percepts/percepts.dart';

import '../../../build_context_extensions.dart';
import '../../editor/cognition/considerations/opening_file.dart';
import '../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../beliefs/file_system_entity_name.dart';
import '../models/directory_model.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: StreamOfConsciousness<IDEBeliefs, DirectoryModel>(
        infer: (beliefs) => DirectoryModel(beliefs.workspace.entityNames),
        builder: (context, model) {
          return ListView(children: [
            ...model.fileSystemEntityNames.map<Widget>(
              (element) => ListTile(
                leading: const Icon(
                  Icons.file_copy,
                  size: 20,
                ),
                title: Text(element.basename),
                onTap: () {
                  context.consider(OpeningFile(fileName: element));
                  // codeChangeNotifier.remove();
                  // File file = File('${element.dirname}/${element.basename}');
                  // codeChangeNotifier.add(file.readAsStringSync());
                },
              ),
            )
          ]);
        },
      ),
    );
  }
}
