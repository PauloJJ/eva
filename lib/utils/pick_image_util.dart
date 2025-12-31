import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageUtil({bool? cameraGrip}) async {
  XFile? image = await ImagePicker().pickImage(
    source: cameraGrip == true ? ImageSource.camera : ImageSource.gallery,
    imageQuality: cameraGrip == true ? 70 : 30,
    maxWidth: cameraGrip == true ? 1920 : null,
    maxHeight: cameraGrip == true ? 1920 : null,
    preferredCameraDevice: CameraDevice.rear,
  );

  if (image != null) {
    return image;
  }

  return null;
}

Future<XFile?> pickVideoUtil() async {
  XFile? image = await ImagePicker().pickVideo(source: ImageSource.camera);

  if (image != null) {
    return image;
  }

  return null;
}
