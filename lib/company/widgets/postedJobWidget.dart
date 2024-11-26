import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';
import 'package:hustlehub/utils/constants.dart';


class PostedJobWidget extends StatefulWidget {
  final Map<String, dynamic> jobData;
  final  companyData; // Final variable to hold job data
   final VoidCallback onJobDeleted;
  PostedJobWidget({super.key, required this.jobData,required this.companyData, required this.onJobDeleted, });

  @override
  State<PostedJobWidget> createState() => _PostedJobWidgetState();
}

class _PostedJobWidgetState extends State<PostedJobWidget> {
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

  @override
  Widget build(BuildContext context) {
    

    // Extract job details from the jobData map
    final String jobTitle = widget.jobData['jobId'] ?? 'Unknown Title';
    final String initialSalary = widget.jobData['initialSalary'] ?? '400'; 
    final String finalSalary = widget.jobData['finalSalary'] ?? '900'; 
    final String currency = widget.jobData['currency']??'USD';
    final String jobLocation = widget.jobData['jobLocation'] ?? 'Remote';
    final int applicationCount = widget.jobData['applicationCount'] ?? 0;
    final String companyName = widget.companyData.company ?? 'unknown';
    final String date = calculateTimeAgo(widget.jobData['date']);
    final List<dynamic> applications = widget.jobData['applications'];
    final Map<String,dynamic> applicationData = {
      'docId':widget.jobData['docId'],
      'jobId':widget.jobData['jobId'],
      'applications':widget.jobData['applications']
    };


    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: kcontainerColor),
      ),
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
                    jobTitle, // Dynamically display job title
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kfontColor,
                    ),
                  ),
                  Text(
                    companyName, // Placeholder for company name if required
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () async{
                  await FirestoreServices().deleteJobData(jobTitle, context);
                   widget.onJobDeleted();
                  
                }, 
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(Icons.location_on, size: 20),
              widthInRow,
              Text(
                jobLocation, // Dynamically display job location
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kfontColor,
                ),
              ),
            ],
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(Icons.paid, size: 20),
              const SizedBox(width: 10),
              Text(
                '$initialSalary $currency - $finalSalary $currency',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kfontColor,
                ),
              ),
            ],
          ),
          kheightinRec,
          kheightinRec,
          Row(
            children: const [
              // Add other job detail widgets (like remote or experience) here if needed
            ],
          ),
          kheightinRec,
          kheightinRec,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ktextColor, width: 0.5),
            ),
          ),
          kheightinRec,
          Row(
            children: [
              const Icon(Icons.history, size: 18, color: ktextColor),
              const SizedBox(width: 10),
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: ktextColor,
                ),
              ),
              GestureDetector(
                onTap: () {

                  Navigator.pushNamed(context, AppRoute.applicationScreen,arguments: applicationData);
                },
                child: Text(
                  "$applicationCount Applications", // Display application count
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: kshowAllColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
