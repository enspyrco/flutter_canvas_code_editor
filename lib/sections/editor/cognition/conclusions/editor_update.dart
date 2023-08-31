import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../workspace/beliefs/file_system_entity_name.dart';

class EditorUpdate extends Conclusion<IDEBeliefs> {
  const EditorUpdate(
      {FileSystemEntityName? currentFileName, String? currentFileContents})
      : _currentFileName = currentFileName,
        _currentFileContents = currentFileContents;

  final FileSystemEntityName? _currentFileName;
  final String? _currentFileContents;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return beliefs.copyWith(
      editor: beliefs.editor.copyWith(
        currentFileName: _currentFileName,
        currentFileContents: _currentFileContents,
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'OpenFileUpdate',
        'state_': {
          'currentFileName': _currentFileName?.toJson(),
          'currentFileContents': _currentFileContents,
        },
      };
}
