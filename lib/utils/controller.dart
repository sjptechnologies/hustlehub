import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/services/firebaseStorage.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';

import 'package:image_picker/image_picker.dart';



File ? imageFile;
FireStorage fireStorage = FireStorage();
FirestoreServices firestoreServices = FirestoreServices();

final ImagePicker _picker = ImagePicker();




String calculateTimeAgo(String? jobDate) {
    if (jobDate == null) return "Date not available - ";

    DateTime postedDate = DateTime.parse(jobDate); // Parse the job date
    final now = DateTime.now();
    final difference = now.difference(postedDate);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago - ';
    } else if (difference.inDays == 1) {
      return '1 day ago - ';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago - ';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago - ';
    } else {
      return 'Just now - ';
    }
  }  

// Function to pick an image from the gallery
  Future<void> pickImage(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
    
        imageFile =
            File(pickedFile.path); // Convert the picked file to a File object
   

      try {
        String? imageUrl = await fireStorage.storeImage(pickedFile);
        if (imageUrl != null) {
          // Save the image URL to Firestore
          await firestoreServices.saveImageUrlToFirestore(imageUrl);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image Uploaded Successfully')),
          );
        }
      } on FirebaseException catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!)),
        );
      }
    }
  }


Future<void> storeApplicationtoFireStore({required File resume,required String jobId,required String companyId,required String name,required String email,required String phno, required String indro}) async{
  try{
    
    String? resumeUrl = await fireStorage.storeResume(resume);
    if(resumeUrl != null){
      final applicantData = {
        'name':name,
        'email':email,
        'phone':phno,
        'indroduction':indro,
        'resumeUrl':resumeUrl
      };

      await firestoreServices.applyJob(companyId: companyId, jobId: jobId, applicantDetails: applicantData);
    }else{
      throw Exception('Somthing went wrong');
    }
  }
  catch(e){
    rethrow;
  }


}

Future<void> updateStatus({
  required String name,
  required String email,
  required String phno,
  required String status, // The status to be updated (approved, rejected, etc.)
  required String companyId,
  required String jobId,
}) async {
  try {
    // Get the job document from Firestore
    var jobDocSnapshot = await FirebaseFirestore.instance
        .collection('Companies') // Companies collection
        .doc(companyId) // Specific company ID
        .collection('Jobs') // Jobs collection
        .doc(jobId) // Specific job ID
        .get();

    // Check if the job exists
    if (jobDocSnapshot.exists) {
      // Get the job data
      var jobData = jobDocSnapshot.data();

      // Assuming applicants are stored in an "applications" field (as a list of maps)
      List<dynamic> applicants = jobData?['applications'] ?? [];

      // Find the applicant with the matching name, email, and phone
      var applicantIndex = applicants.indexWhere((applicant) =>
          applicant['name'] == name &&
          applicant['email'] == email &&
          applicant['phone'] == phno);

      if (applicantIndex != -1) {
        // If a match is found, update the status for the applicant
        applicants[applicantIndex]['status'] = status;
        
        // Update the job document with the new applicants list
        await jobDocSnapshot.reference.update({
          'applications': applicants,
        });

      } else {
        throw Exception('Applicant not found');
      }
    } else {
      throw Exception('Job not found');
    }
  } catch (e) {
    rethrow; // Re-throws the error after logging
  }
}






Future<List<Map<String,dynamic>>> fetchRecommendedajobs({required String userRole}) async{
  List<Map<String,dynamic>> fetchedJobs = await firestoreServices.fetchRecommendedJobs(userRole: userRole);
  return fetchedJobs;
  
}

Future<List<Map<String,dynamic>>> fetchAndDisplayAllJobs({String? query}) async {
    // Fetch jobs posted by all companies
    List<Map<String, dynamic>> fetchedJobs = await firestoreServices.fetchAllJobs();
    
 if (query != null && query.isNotEmpty) {
    // Filter jobs based on query
    fetchedJobs = fetchedJobs.where((job) {
      return job['jobTitle'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }   
    return fetchedJobs;
  }