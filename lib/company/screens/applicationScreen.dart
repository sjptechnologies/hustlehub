import 'package:flutter/material.dart';
import 'package:hustlehub/company/widgets/applicationWidget.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';


class ApplicationScreen extends StatefulWidget {
  Map<String,dynamic> applications;
  ApplicationScreen({super.key,required this.applications});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {

  @override
  Widget build(BuildContext context) {
    List<dynamic> applications = widget.applications['applications'];
    
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: applications.length,
          itemBuilder: (context, index) {
            Map<String,dynamic> applicantDetails = {
              'docId':widget.applications['docId'],
              'jobId':widget.applications['jobId'],
              'name':applications[index]['name'],
              'email':applications[index]['email'],
              'phone':applications[index]['phone'],
              'indroduction':applications[index]['indroduction'],
              'resumeUrl':applications[index]['resumeUrl']
            };


          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.singleApplicationScreen,arguments: applicantDetails);
            },
            child: ApplicationWidget(applications: applications[index],),
          );
        },),
      ),
    ));
  }
}