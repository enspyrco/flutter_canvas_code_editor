import 'package:abstractions/beliefs.dart';
import 'package:file/file.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:path/path.dart';

import '../../../analysis/cognition/considerations/starting_analysis_server.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../../systems/file_system_system.dart';
import '../../beliefs/file_system_entity_name.dart';
import '../../beliefs/opening_directory_state.dart';
import '../conclusions/workspace_updates.dart';

class OpeningDirectory extends Consideration<IDEBeliefs> {
  const OpeningDirectory({required String path}) : _path = path;

  final String _path;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    beliefSystem.conclude(
        WorkspaceUpdates(openingDirectoryState: OpeningDirectoryState.opening));

    var fileSystemSystem = locate<FileSystemSystem>();

    List<FileSystemEntity> entities =
        await fileSystemSystem.openDirectory(_path);

    beliefSystem.consider(StartingAnalysisServer(
        directory: fileSystemSystem.directoryFromPath(_path)));

    beliefSystem.conclude(
      WorkspaceUpdates(
        openingDirectoryState: OpeningDirectoryState.opening,
        directoryPath: _path,
        entityNames: entities.map<FileSystemEntityName>(
          (FileSystemEntity e) {
            return FileSystemEntityName(
              basename: basename(e.path),
              dirname: dirname(e.path),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'OpeningDirectory',
        'state_': {'path': _path}
      };
}
