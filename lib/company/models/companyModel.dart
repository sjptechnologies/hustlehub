import 'package:flutter/foundation.dart';

class CompanyModel {
  String? email;
  String? company;
  List<Map<String, dynamic>>? jobs; // List of jobs as map (subcollection)

  CompanyModel({
    this.email,
    this.company,
    this.jobs,
  });

  Map<String, dynamic> toMap() {
    //tomap to store data to firestore
    return {
      if (company != null) 'company': company,
      if (email != null) 'email': email,
    };
  }

   // Convert individual job data to a Map
  Map<String, dynamic> jobDataToMap(Map<String, dynamic> job) {
    return {
      'finalSalary': job['finalSalary'],
      'jobLocation': job['jobLocation'],
      'jobType': job['jobType'],
      'experience': job['experience'],
      'applicationCount': job['applicationCount'],
      'date': job['date'],
      'desc': job['desc'],
      'oppurtunityType': job['oppurtunityType'],
      'skills': job['skills'],
      'jobTime': job['jobTime'],
      'openingsCount': job['openingsCount'],
      'currency': job['currency'],
      'initialSalary': job['initialSalary'],
      'preference': job['preference'],
      'perks': job['perks'],
      'applications':[],
      'latlng':job['latlng'],
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    //fetch data from firebase
    return CompanyModel(
      company: map['company'],
      email: map['email'],
       jobs: (map['jobs'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList(),
    );
  }
}
