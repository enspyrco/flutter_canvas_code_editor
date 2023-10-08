import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:percepts/percepts.dart';

import '../../../utils/build_context_extensions.dart';
import '../../editor/cognition/considerations/opening_file.dart';
import '../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../beliefs/file_system_entity_beliefs.dart';
import '../models/file_system_entity_model.dart';
import '../models/workspace_view_model.dart';

/// The [WorkspaceView] represents a 'perceived' view of the IDE's workspace,
/// meaning whenever [WorkspaceBeliefs] change, a new [WorkspaceViewModel] is
/// inferred and the [WorkspaceView] rebuilds to represent the updated Beliefs.
class WorkspaceView extends StatefulWidget {
  const WorkspaceView({super.key});

  @override
  State<WorkspaceView> createState() => _WorkspaceViewState();
}

class _WorkspaceViewState extends State<WorkspaceView> {
  final treeController = TreeController<FileSystemEntityModel>(
    roots: [],
    childrenProvider: (FileSystemEntityModel node) => node.children,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: StreamOfConsciousness<IDEBeliefs, WorkspaceViewModel>(
        infer: (beliefs) => WorkspaceViewModel(
            fileSystemEntityBeliefsList: beliefs.workspace.fileSystemEntities),
        builder: (context, viewModel) {
          // Set the roots of the tree controller now that we have the data.
          treeController.roots = viewModel.fileSystemEntityModels;

          return TreeView<FileSystemEntityModel>(
              treeController: treeController,
              nodeBuilder: (context, TreeEntry<FileSystemEntityModel> entry) {
                return TreeIndentation(
                  entry: entry,
                  child: ListTile(
                    leading: entry.node.icon,
                    title: Text(entry.node.beliefs.basename),
                    onTap: () {
                      if (entry.node.beliefs.type == EntityType.directory) {
                        treeController.toggleExpansion(entry.node);
                      } else {
                        context
                            .consider(OpeningFile(beliefs: entry.node.beliefs));
                        // codeChangeNotifier.remove();
                        // File file = File('${element.dirname}/${element.basename}');
                        // codeChangeNotifier.add(file.readAsStringSync());
                      }
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
