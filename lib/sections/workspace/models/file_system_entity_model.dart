import 'package:flutter/material.dart';

import '../beliefs/file_system_entity_beliefs.dart';

/// The [FileSystemEntityModel] is inferred from (and wraps)
/// [FileSystemEntityBeliefs]. The model adds an icon that is used in the
/// [WorkspaceView] to give a visual indication of the type the FileSystemEntity.
class FileSystemEntityModel {
  FileSystemEntityModel(this.beliefs)
      : icon = _iconForEntityType[beliefs.type] ??
            const Icon(
              Icons.question_mark,
              size: 20,
            );

  static const Map<EntityType, Icon> _iconForEntityType = {
    EntityType.dartFile: Icon(
      Icons.logo_dev,
      size: 20,
    ),
    EntityType.yamlFile: Icon(
      Icons.file_copy_outlined,
      size: 20,
    ),
    EntityType.generalFile: Icon(
      Icons.file_present,
      size: 20,
    ),
    EntityType.directory: Icon(
      Icons.folder,
      size: 20,
    ),
  };

  final Icon icon;
  final FileSystemEntityBeliefs beliefs;
}
