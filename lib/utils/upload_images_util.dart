import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage({
  required String folderName,
  required File fileImage,
}) async {
  try {
    String imageName = Random().nextDouble().toString();

    final ref = FirebaseStorage.instance.ref().child(
      '$folderName/$imageName',
    );

    await ref.putFile(File(fileImage.path));

    String urlImage = await ref.getDownloadURL();

    return urlImage;
  } catch (_) {
    return null;
  }
}
