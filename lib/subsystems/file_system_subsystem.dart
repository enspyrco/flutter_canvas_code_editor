import 'package:abstractions/subsystem.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart';

import '../sections/workspace/beliefs/file_system_entity_beliefs.dart';

/// The [FileSystemSubsystem] is a [Subsystem] of [perception] that provides
/// access to the local file system, allowing opening directories, files, ...
class FileSystemSubsystem implements Subsystem {
  const FileSystemSubsystem({FileSystem? fileSystem})
      : fs = fileSystem ?? const LocalFileSystem();

  final FileSystem fs;

  Future<List<FileSystemEntityBeliefs>> openDirectory(String path) async {
    final beliefs = <FileSystemEntityBeliefs>[];

    await for (FileSystemEntity entity in fs.directory(path).list()) {
      // calculate the values that constitute FileSystemEntityBeliefs
      final String baseName = basename(entity.path);
      final String dirName = dirname(entity.path);
      final String fileExtension = extension(entity.path);
      final EntityType type = switch (entity) {
        Directory() => EntityType.directory,
        File() when fileExtension == '.dart' => EntityType.dartFile,
        File() when fileExtension == '.yaml' => EntityType.yamlFile,
        File() when fileExtension == '.lock' => EntityType.lockFile,
        Link() => EntityType.link,
        _ => EntityType.unknown,
      };

      List<FileSystemEntityBeliefs> children =
          (entity is Directory) ? await openDirectory(entity.path) : [];

      beliefs.add(
        FileSystemEntityBeliefs(
          basename: baseName,
          dirname: dirName,
          type: type,
          extension: fileExtension,
          children: children,
        ),
      );
    }

    return beliefs;
  }

  Directory directoryFromPath(String path) => fs.directory(path);

  String getFileContents(String filePath) {
    return fs.file(filePath).readAsStringSync();
  }
}
