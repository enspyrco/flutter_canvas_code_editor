import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../../../../systems/file_picker_system.dart';
import 'opening_directory.dart';

class PromptingForDirectory extends Consideration<IDEBeliefs> {
  const PromptingForDirectory();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<FilePickerSystem>();

    String? selectedDirectory = await service.selectDirectory();

    if (selectedDirectory == null) {
      // User canceled the picker
    } else {
      beliefSystem.consider(OpeningDirectory(path: selectedDirectory));
    }
  }

  @override
  toJson() => {'name_': 'PromptingForDirectory', 'state_': <String, Object?>{}};
}
