import 'package:abstractions/beliefs.dart';

import 'file_system_entity_beliefs.dart';
import 'opening_directory_state.dart';

class WorkspaceBeliefs implements CoreBeliefs {
  WorkspaceBeliefs({
    required this.openingState,
    required this.directoryPath,
    required this.fileSystemEntities,
  });

  final OpeningDirectoryState? openingState;
  final String? directoryPath;
  final List<FileSystemEntityBeliefs> fileSystemEntities;

  static WorkspaceBeliefs get initial => WorkspaceBeliefs(
        openingState: null,
        directoryPath: null,
        fileSystemEntities: [],
      );

  @override
  WorkspaceBeliefs copyWith({
    OpeningDirectoryState? openingState,
    String? directoryPath,
    List<FileSystemEntityBeliefs>? fileSystemEntities,
  }) =>
      WorkspaceBeliefs(
        openingState: openingState ?? this.openingState,
        directoryPath: directoryPath ?? this.directoryPath,
        fileSystemEntities: fileSystemEntities ?? this.fileSystemEntities,
      );

  @override
  toJson() => {
        'openingState': openingState,
        'directoryPath': directoryPath,
        'fileSystemEntities': fileSystemEntities,
      };
}
