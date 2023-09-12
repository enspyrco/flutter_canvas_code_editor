import 'package:file_picker/file_picker.dart';

class FilePickerSystem {
  const FilePickerSystem({FilePicker? plugin});

  Future<String?> selectDirectory() async {
    return FilePicker.platform.getDirectoryPath();
  }
}
