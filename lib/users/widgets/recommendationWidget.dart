import 'package:flutter/material.dart';
import 'package:hustlehub/users/widgets/jobdetailsWidget.dart';
import 'package:hustlehub/utils/constants.dart';

import '../../services/local_database.dart';
import '../../utils/controller.dart';


class RecommendationWidget extends StatefulWidget {
  Map<String, dynamic> jobDetails;
  int index;
  RecommendationWidget({super.key, required this.jobDetails,required this.index});

  @override
  State<RecommendationWidget> createState() => _RecommendationWidgetState();
}

class _RecommendationWidgetState extends State<RecommendationWidget> {
  

  LocalDatabse ldb = LocalDatabse();
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    
    isSaved = await ldb.isJobSaved(
      widget.jobDetails['jobTitle'],
      widget.jobDetails['companyName'],
    );
    setState(() {});
  
  }
  


  @override
  Widget build(BuildContext context) {

    String title = widget.jobDetails['jobTitle'];
    String companyName = widget.jobDetails['companyName'];
    String location = widget.jobDetails['jobDetails']['jobLocation'];
    String initialSalary = widget.jobDetails['jobDetails']['initialSalary'] +
        widget.jobDetails['jobDetails']['currency'];
    String finalSalary = widget.jobDetails['jobDetails']['finalSalary'] +
        widget.jobDetails['jobDetails']['currency'];
    String jobType = widget.jobDetails['jobDetails']['jobType'];
    String oppurtunityType = widget.jobDetails['jobDetails']['oppurtunityType'];
    int experience = widget.jobDetails['jobDetails']['experience'];
    String dateOfPost = widget.jobDetails['jobDetails']['date'];
    int applicationCount =
        widget.jobDetails['jobDetails']['applicationCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(
            color: kcontainerColor,
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.radio_button_checked),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kfontColor),
                  ),
                  Text(companyName)
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async{
                    
                     setState(() {
                    isSaved = !isSaved;
                  });
                    if (isSaved){
                    await ldb.insertValue(
                        title: title,
                        companyName: companyName,
                        location: location,
                        initialSalary: initialSalary,
                        finalSalary: finalSalary,
                        jobType: jobType,
                        oppurtunityType: oppurtunityType,
                        dateOfPost: dateOfPost,
                        experience: experience,
                        applicationCount: applicationCount,
                        isSaved:true);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved Successfully')));
                    }
                    else{
                       await ldb.deleteValue(title: title, companyName: companyName, location: location, initialSalary: initialSalary, finalSalary: finalSalary, jobType: jobType, oppurtunityType: oppurtunityType, dateOfPost: dateOfPost, experience: experience, applicationCount: applicationCount) ;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed Successefully')));
                    }
                  },
                  icon:  Icon(isSaved?Icons.bookmark: Icons.bookmark_outline))
            ],
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 20,
              ),
              widthInRow,
              Text(
                location,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kfontColor),
              )
            ],
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(
                Icons.paid,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "$initialSalary - $finalSalary",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kfontColor),
              )
            ],
          ),
          kheightinRec,
          kheightinRec,
          Row(
            children: [
              JobScreenWidget(
                icon: const Icon(
                  Icons.video_camera_front,
                  size: 18,
                ),
                text: jobType,
              ),
              JobScreenWidget(
                icon: const Icon(
                  Icons.access_time_filled,
                  size: 18,
                ),
                text: oppurtunityType,
              ),
              JobScreenWidget(
                icon: const Icon(
                  Icons.business_center,
                  size: 18,
                ),
                text: "$experience Year of Exp",
              ),
            ],
          ),
          kheightinRec,
          kheightinRec,
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: ktextColor, width: 0.5)),
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(
                Icons.history,
                size: 18,
                color: ktextColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                calculateTimeAgo(dateOfPost),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: ktextColor),
              ),
              Text(
                '$applicationCount Applications',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: kshowAllColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
