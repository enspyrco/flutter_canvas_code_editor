import 'package:file/file.dart';
import 'package:file/local.dart';

class FileSystemSystem {
  const FileSystemSystem({FileSystem? fileSystem})
      : fs = fileSystem ?? const LocalFileSystem();

  final FileSystem fs;

  Future<List<FileSystemEntity>> openDirectory(String path) async {
    final entities = <FileSystemEntity>[];

    await for (FileSystemEntity entity in fs.directory(path).list()) {
      entities.add(entity);
    }

    return entities;
  }

  Directory directoryFromPath(String path) => fs.directory(path);

  String getFileContents(String filePath) {
    return fs.file(filePath).readAsStringSync();
  }
}
