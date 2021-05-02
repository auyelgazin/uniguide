import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  
  static UploadTask uploadFile(String destination, File imageFile){

    try{
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(imageFile);
    } on FirebaseException catch(e) {
      return null;
    }

  }
}