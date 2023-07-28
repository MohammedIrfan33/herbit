import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowCompression: true);

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return  downloadUrl;
    }else{
      return '';
    }
  }

bool checkImageUrl(String imageUrl){
  return imageUrl.contains('.jpg') ||
         imageUrl.contains('.jpeg') ||
         imageUrl.contains('.png') ||
         imageUrl.contains('.gif') ||
         imageUrl.contains('.bmp');
}