import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireStorage {
  Future<String?> storeImage(XFile imageFile) async {
    try {
      // Create a reference to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('uploads/$fileName');

      // Upload the file
      UploadTask uploadTask = ref.putFile(File(imageFile.path));
      TaskSnapshot snapshot = await uploadTask;

      // Get the image URL after uploading
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // print('Error occurred while uploading image: $e');
      rethrow;
    }
  }

  Future<String?> storeResume(File? resume) async {

    if (resume != null) {


      try {
          final storageRef = FirebaseStorage.instance.ref('resumes/');
          await storageRef.putFile(resume);
          final downloadUrl = await storageRef.getDownloadURL();
          print('File uploaded successfully. Download URL: $downloadUrl');
          return downloadUrl;
        } catch (e) {
          // print('Error uploading file: $e');
          rethrow;
        }
          
    
      
   


     
    }
    return null;
  }
}
