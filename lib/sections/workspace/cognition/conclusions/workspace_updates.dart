import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../beliefs/file_system_entity_name.dart';
import '../../beliefs/opening_directory_state.dart';

class WorkspaceUpdates extends Conclusion<IDEBeliefs> {
  WorkspaceUpdates({
    OpeningDirectoryState? openingDirectoryState,
    String? directoryPath,
    List<FileSystemEntityName>? entityNames,
  })  : _openingDirectoryState = openingDirectoryState,
        _directoryPath = directoryPath,
        _entityNames = entityNames;

  final OpeningDirectoryState? _openingDirectoryState;
  final String? _directoryPath;
  final List<FileSystemEntityName>? _entityNames;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return beliefs.copyWith(
      workspace: beliefs.workspace.copyWith(
        openingState: _openingDirectoryState,
        directoryPath: _directoryPath,
        entityNames: _entityNames,
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'WorkspaceUpdates',
        'state_': {
          'openingDirectoryState': _openingDirectoryState,
          'directoryPath': _directoryPath,
          'entityNames': _entityNames,
        }
      };
}
