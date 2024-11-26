import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hustlehub/company/models/companyModel.dart';
import 'package:hustlehub/company/widgets/addJobWidgets/jobDetails.dart';
import 'package:hustlehub/company/widgets/addJobWidgets/oppurtunityTypeWidget.dart';
import 'package:hustlehub/company/widgets/addJobWidgets/salaryWidget.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';
import 'package:hustlehub/utils/constants.dart';
import 'package:intl/intl.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  FirestoreServices firestoreServices = FirestoreServices();

  String? selectedOpportunityType; // State for selected opportunity type
  String? jobTitle;
  String? skillsRequired;
  int? yearsOfExp;
  String? jobType;
  String? location;
  String? jobTime;
  int? openingsCount;
  List<String> jobDesc = [];
  List<String> preference = [];
  String? currency;
  String? initialSalary;
  String? finalSalary;
  List<String> perks = [];
  LatLng? latlng;

  

  void updateData() async {
    
    try {
      // Job-specific data
      Map<String, dynamic> jobData = {
        'jobTitle':jobTitle ?? 'no title',
        'finalSalary': finalSalary ?? '0',
        'jobLocation': location ?? jobType,
        'jobType': jobType ?? 'unknown',
        'experience': yearsOfExp ?? '0',
        'latlng':latlng != null
          ? {'latitude': latlng!.latitude, 'longitude': latlng!.longitude}
          : 'unknown',
      
        'date': DateTime.now().toString() ,
        'desc': jobDesc,
        'oppurtunityType': selectedOpportunityType ?? 'unknown',
        'skills': skillsRequired ,
        'jobTime':jobTime ?? 'unknown',
        'openingsCount': openingsCount ?? 'unknown',
        'currency': currency ?? 'unknown',
        'initialSalary': initialSalary ?? 'unknown',
        'preference': preference ,
        'perks': perks ,
      };

       User? user = FirebaseAuth.instance.currentUser;
       String? userEmail = user?.email;
       String? companyName;

       if (user != null) {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Companies')
        .doc(user.uid)
        .get();

    if (doc.exists) {
       companyName = doc['company'] as String?;// This will return the company name if it exists
    }
       }

       
       // Assuming you have the email and company name
    CompanyModel company = CompanyModel(
      email: userEmail, // Replace with actual email
      company: companyName, // Replace with actual company name
    );

        // Update company data with job
  await firestoreServices.updateCompanyData(company, jobTitle.toString(), jobData);

  
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Updloaded Successfully')));
      Navigator.pop(context,true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
          print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Internship/Job'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ksizedBoxHeight,
                OppurtunityTypeWidget(
                  opportunityType: (String? value) {
                    setState(() {
                      selectedOpportunityType =
                          value; // Update the state with the selected value
                    });
                  },
                ),
                ksizedBoxHeight,
                JobDetailsWidget(
                  jobTitle: (String? value) {
                    setState(() {
                      jobTitle = value;
                    });
                  },
                  yearsOfExp: (int? value) {
                    setState(() {
                      yearsOfExp = value;
                    });
                  },
                  skillsRequired: (value) {
                    setState(() {
                      skillsRequired = value;
                    });
                  },
                  jobType: (value) {
                    setState(() {
                      jobType = value;
                    });
                  },
                  location: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  latlng:(value){
                    setState(() {
                      latlng = value;
                    });
                  },
                  jobTime: (value) {
                    setState(() {
                      jobTime = value;
                    });
                  },
                  openingsCount: (value) {
                    setState(() {
                      openingsCount = value;
                    });
                  },
                  jobDesc: (value) {
                    setState(() {
                      jobDesc = value;
                    });
                  },
                  preferences: (value) {
                    preference = value;
                  },
                ),
                ksizedBoxHeight,
                SalaryWidget(
                  currencyType: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        currency = value;
                      });
                    });
                  },
                  initialSalary: (value) {
                    initialSalary = value;
                  },
                  finalSalary: (value) {
                    finalSalary = value;
                  },
                  perks: (value) {
                    perks = value;
                  },
                ),
                ksizedBoxHeight,
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          kfontColor,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Set border radius
                          ),
                        ),
                      ),
                      onPressed: () {
                        updateData();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
                kheightinRec
              ],
            ),
          ),
        ),
      ),
    );
  }
}
