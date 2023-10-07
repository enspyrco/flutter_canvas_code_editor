import 'package:abstractions/beliefs.dart';

enum EntityType {
  generalFile,
  dartFile,
  yamlFile,
  lockFile,
  hiddenFile,
  directory,
  link,
  unknown,
}

class FileSystemEntityBeliefs implements Belief {
  FileSystemEntityBeliefs({
    required this.basename,
    required this.dirname,
    required this.type,
    required this.extension,
  }) : fullName = '$dirname/$basename';

  /// The part of this entity's path after the last separator.
  ///
  ///     context.basename('path/to/foo.dart'); // -> 'foo.dart'
  ///     context.basename('path/to');          // -> 'to'
  ///
  /// Trailing separators are ignored.
  ///
  ///     context.basename('path/to/'); // -> 'to'
  final String basename;

  /// Gets the part of this entity's path before the last separator.
  ///
  ///     context.dirname('path/to/foo.dart'); // -> 'path/to'
  ///     context.dirname('path/to');          // -> 'path'
  ///     context.dirname('foo.dart');         // -> '.'
  ///
  /// Trailing separators are ignored.
  ///
  ///     context.dirname('path/to/'); // -> 'path'
  final String dirname;

  final String fullName;

  final EntityType type;

  final String extension;

  @override
  Belief copyWith() {
    throw 'The entities are provided by the file system and should not be changed';
  }

  @override
  Map<String, Object?> toJson() => {'basename': basename, 'dirname': dirname};
}
