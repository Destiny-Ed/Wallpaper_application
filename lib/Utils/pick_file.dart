import 'package:file_picker/file_picker.dart';

Future<String> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, allowMultiple: false, allowCompression: false);

  if (result != null) {
    final files = result.files.single.path;

    return files!;
  } else {
    return '';
  }
}
