import 'package:flutter/material.dart';
import 'package:hustlehub/services/appliedJobsDatabase.dart';
import 'package:hustlehub/utils/constants.dart';


// ignore: must_be_immutable
class AppliedJobWidget extends StatefulWidget {
  Map<String,dynamic> jobData;

  String selType;
  AppliedJobWidget({super.key,required this.selType,required this.jobData});

  @override
  State<AppliedJobWidget> createState() => _AppliedJobWidgetState();
}

class _AppliedJobWidgetState extends State<AppliedJobWidget> {

AppliedJobsDatabase ajdb = AppliedJobsDatabase();

 

Color selTypeColor(){
  Color textColor =Colors.black;
  if(widget.selType == 'approved'){
    textColor = Colors.green;
  }
  else if(widget.selType == 'rejected'){
    textColor = Colors.red;
  }
  else if(widget.selType == 'reviewed'){
    textColor = Colors.blueAccent.shade700;
  }
  else if(widget.selType == 'in review'){
    textColor = Colors.yellow.shade700;
  }
  else if(widget.selType == 'short listed'){
    textColor = Colors.lightBlue.shade800;
  }
  return textColor;
}

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async{
        await ajdb.deleteValue(
          companyId: widget.jobData['company_id'], 
          jobTime: widget.jobData['job_time'], 
          opportunity_type: widget.jobData['opportunity_type'], 
          openings: widget.jobData['openings'], 
          skill: widget.jobData['skill'], 
          title: widget.jobData['job_title'], 
          companyName: widget.jobData['company_name'], 
          location: widget.jobData['job_location'], 
          salary: widget.jobData['salary'], 
          jobType: widget.jobData['job_type'], 
          dateOfPost: widget.jobData['date'], 
          experience: widget.jobData['experience'], 
          applicationCount: widget.jobData['application_count']);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 15), // Match the margin of the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white, // Match the container's color
          boxShadow: const [
            BoxShadow(
              color: ktextColor,
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 3.0,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 30,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
                      BoxShadow(
                        color: ktextColor,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 3.0,
                       
                      ), 
                      ]//BoxShadow
        ),
        
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(widget.jobData['job_title'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ),
                ),
                Text(widget.jobData['company_name']??'',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14
                ),
                ),
                Text(widget.jobData['job_location'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ktextColor
                ),
                ),
                Text("Submitted, ${widget.jobData['date']}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: ktextColor
                ),
                ),
              ],
            ),
            const Spacer(),
            Column(
             
              children: [
                Text(widget.selType.toUpperCase(),style: TextStyle(
                  color: selTypeColor(),
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                ),),
                ksizedBoxHeight,
                const CircleAvatar(
                  backgroundColor: kcontainerColor,
                  radius: 10,
                  child: Icon(Icons.arrow_forward_ios,size: 10,))
              ],
            )
          ],
        ),
      ),
    );
  }
}