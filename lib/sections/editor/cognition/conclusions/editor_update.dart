import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../workspace/beliefs/file_system_entity_name.dart';

class EditorUpdate extends Conclusion<IDEBeliefs> {
  const EditorUpdate(
      {FileSystemEntityName? currentFileName,
      Map<String, String>? characterMap})
      : _currentFileName = currentFileName,
        _characterMap = characterMap;

  final FileSystemEntityName? _currentFileName;
  final Map<String, String>? _characterMap;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return beliefs.copyWith(
      editor: beliefs.editor.copyWith(
        currentFileName: _currentFileName,
        characterMap: _characterMap,
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'OpenFileUpdate',
        'state_': {
          'currentFileName': _currentFileName?.toJson(),
          'characterMap': _characterMap,
        },
      };
}
