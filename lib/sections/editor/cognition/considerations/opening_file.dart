import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../subsystems/file_system_subsystem.dart';
import '../../../../subsystems/identity_subystem.dart';
import '../../../../utils/global_state.dart';
import '../../../analysis/cognition/considerations/requesting_semantic_tokens.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../workspace/beliefs/file_system_entity_beliefs.dart';
import '../conclusions/editor_update.dart';

class OpeningFile extends Consideration<IDEBeliefs> {
  const OpeningFile({required FileSystemEntityBeliefs beliefs})
      : _beliefs = beliefs;

  final FileSystemEntityBeliefs _beliefs;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final fileSystemSubsystem = locate<FileSystemSubsystem>();
    final identityService = locate<IdentitySubystem>();
    final String currentUserId = identityService.getCurrentUserId();
    // TODO: ensure no @ symbols in currentUserId (as we use it to separate count and id)

    if (_beliefs.basename.split('.').last == 'dart') {
      beliefSystem.consider(
          RequestingSemanticTokens(fileUri: Uri(path: _beliefs.fullName)));
    }

    String fileContents =
        fileSystemSubsystem.getFileContents(_beliefs.fullName);
    int i = 0;

    beliefSystem.conclude(
      EditorUpdate(
        currentFileName: _beliefs,
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
          'fileName': _beliefs.toJson(),
        },
      };
}
