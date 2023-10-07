import 'package:flutter/material.dart';
import 'package:percepts/percepts.dart';

import '../../../utils/build_context_extensions.dart';
import '../../editor/cognition/considerations/opening_file.dart';
import '../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../models/workspace_view_model.dart';

/// The [WorkspaceView] represents a 'perceived' view of the IDE's workspace,
/// meaning whenever [WorkspaceBeliefs] change, a new [WorkspaceViewModel] is
/// inferred and the [WorkspaceView] rebuilds to represent the updated Beliefs.
class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: StreamOfConsciousness<IDEBeliefs, WorkspaceViewModel>(
        infer: (beliefs) => WorkspaceViewModel(
            fileSystemEntityBeliefsList: beliefs.workspace.fileSystemEntities),
        builder: (context, viewModel) {
          return ListView(children: [
            ...viewModel.fileSystemEntityModels.map<Widget>(
              (model) => ListTile(
                leading: model.icon,
                title: Text(model.beliefs.basename),
                onTap: () {
                  context.consider(OpeningFile(beliefs: model.beliefs));
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
