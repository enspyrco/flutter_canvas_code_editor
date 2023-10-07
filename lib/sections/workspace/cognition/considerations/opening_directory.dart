import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../systems/file_system_subsystem.dart';
import '../../../analysis/cognition/considerations/starting_analysis_server.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../beliefs/file_system_entity_beliefs.dart';
import '../../beliefs/opening_directory_state.dart';
import '../conclusions/workspace_updates.dart';

class OpeningDirectory extends Consideration<IDEBeliefs> {
  const OpeningDirectory({required String path}) : _path = path;

  final String _path;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    beliefSystem.conclude(
        WorkspaceUpdates(openingDirectoryState: OpeningDirectoryState.opening));

    var fileSystemSystem = locate<FileSystemSubsystem>();

    List<FileSystemEntityBeliefs> beliefs =
        await fileSystemSystem.openDirectory(_path);

    beliefSystem.consider(StartingAnalysisServer(
        directory: fileSystemSystem.directoryFromPath(_path)));

    beliefSystem.conclude(
      WorkspaceUpdates(
        openingDirectoryState: OpeningDirectoryState.opening,
        directoryPath: _path,
        fileSystemEntities: beliefs,
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'OpeningDirectory',
        'state_': {'path': _path}
      };
}
