import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageFirebaseSaveAnyFiles {

  CloudStorageFirebaseSaveAnyFiles._();

  static CloudStorageFirebaseSaveAnyFiles cloudStorageFirebaseSaveAnyFiles = CloudStorageFirebaseSaveAnyFiles._();

  final _firebaseStorage = FirebaseStorage.instance;


  //TODO image save fire Storage
  Future<void> imageStorageIntoEmail(File image) async {
    final filePath = "Profile/${DateTime.now()}.jpg";
    await _firebaseStorage.ref(filePath).putFile(image);
    String fileSaveImageUrlEmailProfile = await _firebaseStorage.ref(filePath).getDownloadURL();
  }

  //Todo Sander And Receiver image Well be sharing
  Future<String> imageStorageIntoChatSander(File fileImage)
  async {
    final filePath = "image/${fileImage.path}.png";
    await _firebaseStorage.ref(filePath).putFile(fileImage);
    String fileSaveImageUrl = await _firebaseStorage.ref(filePath).getDownloadURL();
    return fileSaveImageUrl;
  }
}