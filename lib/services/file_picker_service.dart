import 'package:file_picker/file_picker.dart';

class FilePickerService {
  const FilePickerService({FilePicker? plugin});

  Future<String?> selectDirectory() async {
    return FilePicker.platform.getDirectoryPath();
  }
}
