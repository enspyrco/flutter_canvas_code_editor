import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../systems/file_system_system.dart';
import '../../../../systems/identity_system.dart';
import '../../../../utils/global_state.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../workspace/beliefs/file_system_entity_name.dart';
import '../conclusions/editor_update.dart';

class OpeningFile extends Consideration<IDEBeliefs> {
  const OpeningFile({required FileSystemEntityName fileName})
      : _fileName = fileName;

  final FileSystemEntityName _fileName;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final fileSystemService = locate<FileSystemSystem>();
    final identityService = locate<IdentitySystem>();
    final String currentUserId = identityService.getCurrentUserId();
    // TODO: ensure no @ symbols in currentUserId (as we use it to separate count and id)

    String fileContents = fileSystemService.getFileContents(_fileName.fullName);
    int i = 0;

    beliefSystem.conclude(
      EditorUpdate(
        currentFileName: _fileName,
        characterMap: {
          for (var character in fileContents.characters)
            '${i++}@$currentUserId': character
        },
      ),
    );

    // this is a sneaky global that bypasses the normal perception stream based
    // state updates, to improve performance of this one common operation
    // This causes the CustomPainter to repaint (and it reads directly from the
    // BeliefSystem so the update() call must come after the `conclude(...` call)
    codeUpdateNotifier.update();
  }

  @override
  toJson() => {
        'name_': 'OpeningFile',
        'state_': {
          'fileName': _fileName.toJson(),
        },
      };
}
