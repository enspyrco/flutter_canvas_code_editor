import '../beliefs/file_system_entity_beliefs.dart';
import 'file_system_entity_model.dart';

/// A [WorkspaceViewModel] is inferred by the [WorkspaceView]'s
/// [StreamOfConsciousness] whenever the [WorkspaceBeliefs] change.
class WorkspaceViewModel {
  WorkspaceViewModel(
      {required List<FileSystemEntityBeliefs> fileSystemEntityBeliefsList})
      : fileSystemEntityModels = fileSystemEntityBeliefsList
            .map<FileSystemEntityModel>(
                (beliefs) => FileSystemEntityModel(beliefs))
            .toList();
  final List<FileSystemEntityModel> fileSystemEntityModels;
}
