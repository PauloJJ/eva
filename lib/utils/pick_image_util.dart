import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageUtil() async {
  XFile? image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 30,
  );

  if (image != null) {
    return image;
  }

  return null;
}
