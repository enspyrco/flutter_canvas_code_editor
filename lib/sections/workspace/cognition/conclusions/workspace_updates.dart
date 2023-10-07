import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../beliefs/file_system_entity_beliefs.dart';
import '../../beliefs/opening_directory_state.dart';
import '../../beliefs/workspace_beliefs.dart';

class WorkspaceUpdates extends Conclusion<IDEBeliefs> {
  WorkspaceUpdates({
    OpeningDirectoryState? openingDirectoryState,
    String? directoryPath,
    List<FileSystemEntityBeliefs>? fileSystemEntities,
  })  : _openingDirectoryState = openingDirectoryState,
        _directoryPath = directoryPath,
        _fileSystemEntities = fileSystemEntities;

  final OpeningDirectoryState? _openingDirectoryState;
  final String? _directoryPath;
  final List<FileSystemEntityBeliefs>? _fileSystemEntities;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    WorkspaceBeliefs newWorkspaceBeliefs = beliefs.workspace.copyWith(
      openingState: _openingDirectoryState,
      directoryPath: _directoryPath,
      fileSystemEntities: _fileSystemEntities,
    );
    return beliefs.copyWith(workspace: newWorkspaceBeliefs);
  }

  @override
  toJson() => {
        'name_': 'WorkspaceUpdates',
        'state_': {
          'openingDirectoryState': _openingDirectoryState,
          'directoryPath': _directoryPath,
          'fileSystemEntities': _fileSystemEntities,
        }
      };
}
