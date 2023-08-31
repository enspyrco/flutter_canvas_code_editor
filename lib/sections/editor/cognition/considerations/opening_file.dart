import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../services/file_system_service.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../workspace/beliefs/file_system_entity_name.dart';
import '../conclusions/editor_update.dart';

class OpeningFile extends Consideration<IDEBeliefs> {
  const OpeningFile({required FileSystemEntityName fileName})
      : _fileName = fileName;

  final FileSystemEntityName _fileName;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    var service = locate<FileSystemService>();

    String fileContents = service.getFileContents(_fileName.fullName);

    beliefSystem.conclude(
      EditorUpdate(
        currentFileName: _fileName,
        currentFileContents: fileContents,
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'OpeningFile',
        'state_': {
          'fileName': _fileName.toJson(),
        },
      };
}
