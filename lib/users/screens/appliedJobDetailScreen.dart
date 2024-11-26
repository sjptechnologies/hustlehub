import 'package:flutter/material.dart';
import 'package:hustlehub/users/widgets/recommandationJobsWidget.dart';
import 'package:hustlehub/utils/constants.dart';


class AppliedJobDetailScreen extends StatelessWidget {
  final jobDetails;
  AppliedJobDetailScreen({super.key,required this.jobDetails});

  @override
  Widget build(BuildContext context) {
  String companyId = jobDetails['company_id']??'0';
    String companyName = jobDetails['companyName']??'';
    final String jobTitle = jobDetails['job_title'];
     String salary = jobDetails['salary'] ; 
     String jobLocation = jobDetails['job_location'] ;
     int applicationCount = jobDetails['application_count'] ?? 0;
     String date = jobDetails['date'];
     String jobType = jobDetails['job_type'];
     String jobTime = jobDetails['job_time'];
     List perks = jobDetails['perks'];
     List prefernce = jobDetails['preference'];
     List description =  jobDetails['description'];
     int experience = jobDetails['experience'];
     int openings = jobDetails['openings'];
     String skill = jobDetails['skill'];

 
    

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
              RecommandationJobsWidget(value: jobTitle, title: 'Title'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: description, title: 'Description'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: jobLocation, title: 'Location'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: jobType, title: 'Oppurtunity Type'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: jobTime, title: 'Working Time'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: salary, title: 'Salary'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: '$experience years', title: 'Experience Required'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: skill, title: 'Skills Required'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: perks, title: 'Perks'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: prefernce, title: 'Candidate Preference'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: date, title: 'Posted Date'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: openings.toString(), title: 'No: of Openings'),
              Divider(
                height: 20,
              ),
               RecommandationJobsWidget(value: applicationCount.toString(), title: 'No of Applications'),
              Divider(
                height: 20,
              ),
             
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    ));
  }
}