import 'package:abstractions/beliefs.dart';

import '../../workspace/beliefs/file_system_entity_beliefs.dart';

class EditorBeliefs implements CoreBeliefs {
  EditorBeliefs({
    required this.currentFileName,
    required this.characterMap,
  });

  final FileSystemEntityBeliefs? currentFileName;
  final Map<String, String>? characterMap;

  static EditorBeliefs get initial => EditorBeliefs(
        currentFileName: null,
        characterMap: null,
      );

  @override
  EditorBeliefs copyWith({
    FileSystemEntityBeliefs? currentFileName,
    Map<String, String>? characterMap,
  }) =>
      EditorBeliefs(
        currentFileName: currentFileName ?? this.currentFileName,
        characterMap: characterMap ?? this.characterMap,
      );

  @override
  toJson() => {
        'currentFileName': currentFileName,
        'characterMap': characterMap,
      };
}
