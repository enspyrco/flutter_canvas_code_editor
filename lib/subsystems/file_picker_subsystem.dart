import 'package:abstractions/subsystem.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerSubsystem implements Subsystem {
  const FilePickerSubsystem({FilePicker? plugin});

  Future<String?> selectDirectory() async {
    return FilePicker.platform.getDirectoryPath();
  }
}
