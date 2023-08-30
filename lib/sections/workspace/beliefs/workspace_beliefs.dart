import 'package:abstractions/beliefs.dart';

import 'file_system_entity_name.dart';
import 'opening_directory_state.dart';

class WorkspaceBeliefs implements CoreBeliefs {
  WorkspaceBeliefs({
    required this.openingState,
    required this.directoryPath,
    required this.entityNames,
  });

  final OpeningDirectoryState? openingState;
  final String? directoryPath;
  final List<FileSystemEntityName> entityNames;

  static WorkspaceBeliefs get initial => WorkspaceBeliefs(
        openingState: null,
        directoryPath: null,
        entityNames: [],
      );

  @override
  WorkspaceBeliefs copyWith({
    OpeningDirectoryState? openingState,
    String? directoryPath,
    List<FileSystemEntityName>? entityNames,
  }) =>
      WorkspaceBeliefs(
        openingState: openingState ?? this.openingState,
        directoryPath: directoryPath ?? this.directoryPath,
        entityNames: entityNames ?? this.entityNames,
      );

  @override
  toJson() => {
        'openingState': openingState,
        'directoryPath': directoryPath,
        'entityNames': entityNames,
      };
}
