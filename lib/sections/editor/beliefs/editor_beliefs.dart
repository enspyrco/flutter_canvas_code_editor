import 'package:abstractions/beliefs.dart';

import '../../workspace/beliefs/file_system_entity_name.dart';

class EditorBeliefs implements CoreBeliefs {
  EditorBeliefs({
    required this.currentFileName,
    required this.currentFileContents,
  });

  final FileSystemEntityName? currentFileName;
  final String? currentFileContents;

  static EditorBeliefs get initial => EditorBeliefs(
        currentFileName: null,
        currentFileContents: null,
      );

  @override
  EditorBeliefs copyWith({
    FileSystemEntityName? currentFileName,
    String? currentFileContents,
  }) =>
      EditorBeliefs(
        currentFileName: currentFileName ?? this.currentFileName,
        currentFileContents: currentFileContents ?? this.currentFileContents,
      );

  @override
  toJson() => {
        'currentFileName': currentFileName,
        'currentFileContents': currentFileContents,
      };
}
