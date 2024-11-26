import 'package:flutter/material.dart';
import 'package:hustlehub/company/widgets/jobDetailScreenWidget.dart';
import 'package:hustlehub/utils/constants.dart';
import 'package:intl/intl.dart';

class JobDetailScreen extends StatelessWidget {
  final jobDetails;
  JobDetailScreen({super.key,required this.jobDetails});

 


  @override
  Widget build(BuildContext context) {

 final String jobTitle = jobDetails['jobTitle'] ;
     String initialSalary = jobDetails['initialSalary'] ; 
     String finalSalary = jobDetails['finalSalary'] ; 
     String currency = jobDetails['currency'];
     String jobLocation = jobDetails['jobLocation'] ;
     int applicationCount = jobDetails['applicationCount'] ?? 0;
     String date = jobDetails['date'];
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
     String jobType = jobDetails['oppurtunityType'];
     String jobTime = jobDetails['jobTime'];
     List perks = jobDetails['perks'];
     List prefernce = jobDetails['preference'];
     List description =  jobDetails['desc'];
     int experience = jobDetails['experience'];
     int openings = jobDetails['openingsCount'];
     String skill = jobDetails['skills'];

    

    return SafeArea(child: Scaffold(
      appBar: AppBar(
         backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              JobDetailScreenWidget(value: jobTitle, title: 'Title'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: description, title: 'Description'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: jobLocation, title: 'Location'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: jobType, title: 'Oppurtunity Type'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: jobTime, title: 'Working Time'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: '$initialSalary $currency - $finalSalary $currency', title: 'Salary'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: '$experience years', title: 'Experience Required'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: skill, title: 'Skills Required'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: perks, title: 'Perks'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: prefernce, title: 'Candidate Preference'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: formattedDate, title: 'Posted Date'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: openings.toString(), title: 'No: of Openings'),
              Divider(
                height: 20,
              ),
               JobDetailScreenWidget(value: applicationCount.toString(), title: 'No of Applications'),
              Divider(
                height: 20,
              )
            ],
          ),
        ),
      ),
    ));
  }
}